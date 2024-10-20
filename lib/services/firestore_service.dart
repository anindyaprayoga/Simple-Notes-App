import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/note.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get notes for current user
  Stream<List<Note>> getNotes(String userId) {
    return _firestore
        .collection('notes')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => Note.fromMap(doc.data(), doc.id))
          .toList();
    });
  }

  // Add note
  Future<void> addNote(Note note) async {
    await _firestore.collection('notes').add(note.toMap());
  }

  // Update note
  Future<void> updateNote(Note note) async {
    await _firestore.collection('notes').doc(note.id).update(note.toMap());
  }

  // Delete note
  Future<void> deleteNote(String noteId) async {
    await _firestore.collection('notes').doc(noteId).delete();
  }
}
