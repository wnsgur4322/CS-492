import 'package:flutter/material.dart';

class JournalEntryDTO {
  String title;
  String body;
  String dateTime;
  int rating;

 

  void setTitle(title) { title = title; }
  void setBody(body) { body = body; }
  void setdateTime(date) { dateTime = date; }
  void setRating(rating) { rating = rating; }

  String toString() => 
    "Title: $title, Body: $body, Date: $dateTime, Rating: $rating";

}