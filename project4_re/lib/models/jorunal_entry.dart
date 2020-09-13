class JournalEntry {
  final String title;
  final String body; 
  final int rate;
  final String date;

  JournalEntry({this.title, this.body, this.rate, this.date});
  
  String toString() {
    return 'Title: $title, Body: $body, Rating: $rate, Date: $date';
  }
}