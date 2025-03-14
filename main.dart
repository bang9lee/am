import 'dart:io'; // 입출력을 처리하기 위한 Dart의 IO 라이브러리 가져오기

class ShoppingMall {
  // 상품 목록을 저장하는 리스트, 각 상품은 이름과 가격을 가진 맵으로 표현
  final List<Map<String, int>> products = [
    {'셔츠': 45000},
    {'원피스': 30000},
    {'반팔티': 35000},
    {'반바지': 38000},
    {'양말': 5000},
  ];
  // 장바구니를 저장하는 리스트, 이름과 개수를 맵으로 저장
  final List<Map<String, int>> cart = [];

  // 상품 목록을 출력하는 메서드
  void _printProducts() {
    for (var p in products)
      print('${p.keys.first} / ${p.values.first}원'); // 각 상품 이름과 가격 출력|
  }

  // 장바구니에 상품을 추가하는 메서드
  void _addToCart() {
    stdout.write('상품 이름을 입력해 주세요 !\n'); // 사용자에게 상품 이름 입력 요청
    final name = stdin.readLineSync()?.trim(); // 입력값을 받아 공백 제거
    if (name == null || !products.any((p) => p.keys.first == name)) {
      // 입력값이 없거나 상품 목록에 없는 경우
      print('입력값이 올바르지 않아요 !.'); // 오류 메시지 출력
      return;
    }

    stdout.write('상품 개수를 입력해 주세요 !\n'); // 상품 개수 입력 요청
    final count =
        int.tryParse(stdin.readLineSync()?.trim() ?? '0') ??
        -2; // 입력값을 정수로 변환, 실패 시 -2
    if (count <= 0) {
      // 개수가 0 이하일 경우
      print('0개보다 많은 개수의 상품만 담을 수 있어요 !'); // 오류 메시지 출력
      return;
    }

    cart.add({name: count}); // 장바구니에 상품 이름과 개수 추가
    print('장바구니에 "$name" $count개 상품이 담겼어요 !'); // 성공 메시지 출력
  }

  // 장바구니에 담긴 상품의 총 가격을 계산하고 출력하는 메서드
  void _showTotal() {
    if (cart.isEmpty) {
      // 장바구니가 비어있는 경우
      print('장바구니가 비어있습니다.');
      return;
    }
    final items = cart
        .map((e) => e.keys.first)
        .join(', '); // 장바구니 상품 이름들을 쉼표로 연결
    final total = cart.fold(
      0,
      (sum, e) =>
          sum +
          e.values.first * // 상품 개수
              products
                  .firstWhere((p) => p.keys.first == e.keys.first) // 해당 상품 찾기
                  .values
                  .first, // 상품 가격
    ); // 총합 계산
    print('장바구니에 $items ${total}원 어치를 담으셨네요 !'); // 결과 출력
  }

  // 장바구니를 초기화하는 메서드
  void _clearCart() {
    if (cart.isEmpty) // 장바구니가 이미 비어있는 경우
      print('이미 장바구니가 비어있습니다.');
    else {
      cart.clear(); // 장바구니 내용 삭제
      print('장바구니를 초기화합니다.');
    }
  }

  // 쇼핑몰 프로그램을 실행하는 주 메서드
  void run() {
    while (true) {
      // 무한 루프를 통해 메뉴 반복 실행
      // 메뉴 옵션 출력
      print(
        "---------------------------------------------------------------------------------------------------------------------------\n"
        "[1] 상품 목록 보기 / [2] 장바구니에 담기 / [3] 장바구니에 담긴 상품의 총 가격 보기 / [4] 프로그램종료 / [6] 장바구니 초기화\n"
        "---------------------------------------------------------------------------------------------------------------------------",
      );

      final choice = stdin.readLineSync()?.trim(); // 사용자 입력 받기
      switch (choice) {
        // 입력값에 따라 기능 실행
        case '1':
          _printProducts(); // 상품 목록 출력
          break;
        case '2':
          _addToCart(); // 장바구니에 상품 추가
          break;
        case '3':
          _showTotal(); // 장바구니 총액 출력
          break;
        case '4':
          stdout.write('정말 종료하시겠습니까? (5 입력 시 종료): '); // 종료 확인 메시지
          if (stdin.readLineSync()?.trim() == '5') {
            // 5 입력 시 종료
            print('이용해 주셔서 감사합니다 ~ 안녕히 가세요 !');
            return; // 프로그램 종료
          }
          print('종료하지 않습니다다.\n'); // 종료 취소 메시지
          break;
        case '6':
          _clearCart(); // 장바구니 초기화
          break;
        default: // 잘못된 입력 처리
          print('잘못된 입력입니다. 1, 2, 3, 4, 6 중 하나를 선택해주세요.\n');
      }
    }
  }
}

// 프로그램의 진입점, ShoppingMall 인스턴스를 생성하고 실행
void main() => ShoppingMall().run();
