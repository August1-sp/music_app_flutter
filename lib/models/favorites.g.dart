// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorites.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavoriteArtistAdapter extends TypeAdapter<FavoriteArtist> {
  @override
  final int typeId = 0;

  @override
  FavoriteArtist read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavoriteArtist(
      id: fields[0] as String,
      name: fields[1] as String,
      thumbnailUrl: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, FavoriteArtist obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.thumbnailUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoriteArtistAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoriteArtist _$FavoriteArtistFromJson(Map<String, dynamic> json) =>
    FavoriteArtist(
      id: json['idArtist'] as String,
      name: json['strArtist'] as String,
      thumbnailUrl: json['strArtistThumb'] as String?,
    );

Map<String, dynamic> _$FavoriteArtistToJson(FavoriteArtist instance) =>
    <String, dynamic>{
      'idArtist': instance.id,
      'strArtist': instance.name,
      'strArtistThumb': instance.thumbnailUrl,
    };
