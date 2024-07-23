import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../constants/colors.dart';
import '../../model/receipt_model.dart';
import '../../services/date_time_util.dart';
import '../../services/receipt_service.dart';
import '../components/appbar.dart';
import 'receipt_detail.dart';

class SeeFavoriteData extends StatefulWidget {
  const SeeFavoriteData({super.key});

  @override
  State<SeeFavoriteData> createState() => _SeeFavoriteDataState();
}

class _SeeFavoriteDataState extends State<SeeFavoriteData> {
  late Future<List<ReceiptModel>> _favoriteReceiptsFuture;
  List<ReceiptModel> _allFavoriteReceipts = [];
  List<ReceiptModel> _filteredFavoriteReceipts = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _favoriteReceiptsFuture = ReceiptService().getFavoriteReceipts();
    _loadFavoriteReceipts();
  }

  void _loadFavoriteReceipts() async {
    final favoriteReceipts = await ReceiptService().getFavoriteReceipts();
    setState(() {
      _allFavoriteReceipts = favoriteReceipts;
      _filteredFavoriteReceipts = favoriteReceipts;
    });
  }

  void _toggleFavorite(int id) async {
    final success = await ReceiptService().toggleFavorite(id);
    if (success) {
      setState(() {
        _favoriteReceiptsFuture = ReceiptService().getFavoriteReceipts();
        _loadFavoriteReceipts();
      });
    }
  }

  void _filterReceipts(String date) {
    try {
      final isoDate = convertToIsoFormat(date);
      final parsedDate = DateTime.parse(isoDate);
      setState(() {
        _filteredFavoriteReceipts = _allFavoriteReceipts.where((receipt) {
          return receipt.dateTime.year == parsedDate.year &&
              receipt.dateTime.month == parsedDate.month &&
              receipt.dateTime.day == parsedDate.day;
        }).toList();
      });
    } catch (e) {
      print(e);
      _showErrorDialog();
    }
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Hata"),
          content:
              const Text("Lütfen gün/ay/yıl formatında bir tarih giriniz."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Tamam"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(children: [
          const Appbar(appbarText: "FAVORİ FİŞLER"),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Fiş Ara (gün/ay/yıl)",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onSubmitted: (value) {
                _filterReceipts(value);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              "Fiş detaylarını görmek için\nkutucuğa tıklayın",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "Montserrat",
                fontSize: 14,
                color: HexColor(fontColor3),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<ReceiptModel>>(
              future: _favoriteReceiptsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Hata: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                      child: Text('Hiç favori fiş bulunamadı.'));
                }

                return ListView.builder(
                  itemCount: _filteredFavoriteReceipts.length,
                  itemBuilder: (context, index) {
                    final receipt = _filteredFavoriteReceipts[index];
                    final formattedDateTime = formatDateTime(receipt.dateTime);
                    final formattedDate = formatDate(receipt.dateTime);
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: HexColor("B8C0E8"),
                          borderRadius: BorderRadius.circular(7.5),
                        ),
                        child: ListTile(
                          title: Text(receipt.marketName),
                          subtitle: Text(
                              'Tarih: $formattedDateTime\nToplam Ürün: ${receipt.totalQuantity}'),
                          trailing: IconButton(
                            icon: receipt.favorite
                                ? const Icon(Icons.favorite, color: Colors.red)
                                : const Icon(Icons.favorite_border,
                                    color: null),
                            onPressed: () {
                              _toggleFavorite(receipt.id);
                            },
                          ),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ReceiptDetail(
                                  date: formattedDate,
                                  receipt: receipt,
                                  allReceipts:
                                      _allFavoriteReceipts, // allReceipts parametresini ekledik
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}
