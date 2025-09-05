//4700

abstract class RBI {
  void interest(); //abstract function
  void HL(); //abstract function
  void CL(); //abstract function
  void notice() {
    print('RBI notice');
  }

  static void repoRate() {
    print('+-4%');
  }
}

class SBI extends RBI {
  @override
  void CL() {
    print('SBI Car Loan : 9.5%');
  }

  @override
  void HL() {
    print('SBI Home Loan : 8.5%');
  }

  @override
  void interest() {
    print('SBI interest : 3.5%');
  }
}

class PNB extends RBI {
  @override
  void CL() {
    print('PNB Car Loan : 10.5%');
  }

  @override
  void HL() {
    print('PNB Home Loan : 9.75%');
  }

  @override
  void interest() {
    print('PNB interest : 3.8%');
  }
}

class DART extends RBI {
  @override
  void CL() {
    print('DART Car Loan : 10.75%');
  }

  @override
  void HL() {
    print('DART Home Loan : 9.55%');
  }

  @override
  void interest() {
    print('DART interest : 3.9%');
  }
}

void main(List<String> args) {
  SBI s = new SBI();
  s.CL();
  s.HL();
  s.interest();
  s.notice();

  PNB p = new PNB();
  p.CL();
  p.HL();
  p.interest();
  s.notice();

  DART d = new DART();
  d.CL();
  d.HL();
  d.interest();
  s.notice();

  RBI.repoRate();
}
