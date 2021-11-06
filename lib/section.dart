import 'phrase.dart';

class Section {
  final int sectionNumber;
  final List<Phrase> _phraseList = [];

  Section(this.sectionNumber);

  Phrase getPhrase(int index) {
    assert(isExist(index));

    return _phraseList[index];
  }

  bool isExist(int phraseIndex) {
    assert(0 <= phraseIndex);

    return 0 <= phraseIndex && phraseIndex <= (_phraseList.length - 1);
  }

  void addPhrase(Phrase phrase) {
    assert(phrase.sectionNumber == sectionNumber);
    assert(!_phraseList.contains(phrase));

    _phraseList.add(phrase);
    _sortPhraseList();
  }

  void _sortPhraseList() {
    _phraseList.sort((a, b) => a.phraseNumber.compareTo(b.phraseNumber));
  }

  bool isLastSection() {
    return sectionNumber == 45;
  }
}
