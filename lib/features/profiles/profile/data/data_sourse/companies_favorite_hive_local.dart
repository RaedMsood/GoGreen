import 'package:gogreen/features/profiles/profile/data/model/companies_favorites_model.dart';
import 'package:hive/hive.dart';

class CompaniesFavoriteHiveLocal {
  static final CompaniesFavoriteHiveLocal _companiesFavoriteHive =
      CompaniesFavoriteHiveLocal._internal();

  factory CompaniesFavoriteHiveLocal() => _companiesFavoriteHive;

  CompaniesFavoriteHiveLocal._internal();

  Future<void> init() async {
    Hive.registerAdapter(CompaniesFavoritesModelAdapter());
    await Hive.openBox<CompaniesFavoritesModel>('companies_fav');
  }

  Future<Box<CompaniesFavoritesModel>> get _box async =>
      await Hive.openBox<CompaniesFavoritesModel>('companies_fav');

  Future<void> add(CompaniesFavoritesModel companiesFavoritesModel) async {
    final box = await _box;
    await box.put(companiesFavoritesModel.id, companiesFavoritesModel);
  }

  Future<void> remove(int id) async {
    final box = await _box;
    await box.delete(id);
  }

  Future<List<CompaniesFavoritesModel>> get all async {
    final box = await _box;
    return box.values.toList();
  }
}

class CompaniesFavoritesModelAdapter
    extends TypeAdapter<CompaniesFavoritesModel> {
  @override
  final int typeId = 4;

  @override
  CompaniesFavoritesModel read(BinaryReader reader) {
    final map = reader.readMap().map(
          (key, value) => MapEntry(key.toString(), value),
        );
    return CompaniesFavoritesModel.fromJson(map);
  }

  @override
  void write(BinaryWriter writer, CompaniesFavoritesModel obj) {
    writer.writeMap(obj.toJson());
  }
}
