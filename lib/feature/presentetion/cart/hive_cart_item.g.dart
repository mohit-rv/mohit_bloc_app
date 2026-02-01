// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_cart_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveCartItemAdapter extends TypeAdapter<HiveCartItem> {
  @override
  final int typeId = 1;

  @override
  HiveCartItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveCartItem(
      productId: fields[0] as int,
      title: fields[1] as String,
      price: fields[2] as double,
      image: fields[3] as String,
      qty: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, HiveCartItem obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.productId)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.price)
      ..writeByte(3)
      ..write(obj.image)
      ..writeByte(4)
      ..write(obj.qty);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveCartItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
