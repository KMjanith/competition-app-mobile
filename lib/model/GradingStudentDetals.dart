class Gradingstudentdetails {
  String _sNo;
  String _currentKyu;
  String _fullName;
  String _paymentStatus;
  String _gradingFees;
  String _paidDate;


  Gradingstudentdetails({
    required String sNo,
    required String currentKyu,
    required String fullName,
    required String gradingFees,
    required String paidDate,

    required String paymentStatus,
  })  : _sNo = sNo,
        _currentKyu = currentKyu,
        _fullName = fullName,
        _gradingFees = gradingFees,
        _paidDate = paidDate,
      
        _paymentStatus = paymentStatus;

  // Getters
  String get sNo => _sNo;
  String get currentKyu => _currentKyu;
  String get fullName => _fullName;
  String get paymentStatus => _paymentStatus;
  String get gradingFees => _gradingFees;
  String get paidDate => _paidDate;
  

  // Setters
  set sNo(String value) => _sNo = value;
  set currentKyu(String value) => _currentKyu = value;
  set fullName(String value) => _fullName = value;
  set paymentStatus(String value) => _paymentStatus = value;
  set gradingFees(String value) => _gradingFees = value;
  set paidDate(String value) => _paidDate = value;
 
}
