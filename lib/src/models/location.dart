import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Location {
  
  final String name;
  final String address;
  final String city;
  final String state;
  final GeoPoint geo;
  final String placesId;

  Location({ 
    @required this.name, 
    @required this.address, 
    @required this.city, 
    @required this.state, 
    this.geo, 
    this.placesId});
  
  Location.fromFirestore(Map<String, dynamic> firestor)
  : name = firestor['name'],
    address = firestor['address'],
    city = firestor['city'],
    state = firestor['state'] ,
    geo = firestor['geo'] ?? null,
    placesId = firestor['placesId'] ?? null; 
}