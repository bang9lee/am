import 'dart:io';

class ShoppingMall {
  final List<Map<String, int>> products = [
    {'셔츠': 45000},
    {'원피스': 30000},
    {'반팔티': 35000},
    {'반바지': 38000},
    {'양말': 5000},
  ];
  final List<Map<String, int>> cart = [];

  void _printProducts() {
    for (var p in products) print('${p.keys.first} / ${p.values.first}원');
    print('');
  }

  void _addToCart() {
    stdout.write('상품 이름을 입력해 주세요 !\n');
    final name = stdin.readLineSync()?.trim();
    if (name == null || !products.any((p) => p.keys.first == name)) {
      print('입력값이 올바르지 않아요 !.');
      return;
    }

    stdout.write('상품 개수를 입력해 주세요 !\n');
    final count = int.tryParse(stdin.readLineSync()?.trim() ?? '0') ?? -2;
    if (count <= 0) {
      print('0개보다 많은 개수의 상품만 담을 수 있어요 !');
      return;
    }

    cart.add({name: count});
    print('장바구니에 "$name" $count개 상품이 담겼어요 !');
  }

  void _showTotal() {
    if (cart.isEmpty) {
      print('장바구니가 비어있습니다.');
      return;
    }
    final items = cart.map((e) => e.keys.first).join(', ');
    final total = cart.fold(
      0,
      (sum, e) =>
          sum +
          e.values.first *
              products
                  .firstWhere((p) => p.keys.first == e.keys.first)
                  .values
                  .first,
    );
    print('장바구니에 $items ${total}원 어치를 담으셨네요 !'); // \n은 = 줄바꿈 출력을 두줄로바꿈꿈
  }

  void _clearCart() {
    if (cart.isEmpty)
      print('이미 장바구니가 비어있습니다.');
    else {
      cart.clear();
      print('장바구니를 초기화합니다.');
    }
  }

  void run() {
    while (true) {
      print(
        '[1] 상품 목록 보기 | [2] 장바구니에 담기 | [3] 장바구니에 담긴 상품의 총 가격 보기 | [4] 프로그램종료 | [6] 장바구니 초기화',
      );
      final choice = stdin.readLineSync()?.trim();
      switch (choice) {
        case '1':
          _printProducts();
          break;
        case '2':
          _addToCart();
          break;
        case '3':
          _showTotal();
          break;
        case '4':
          stdout.write('정말 종료하시겠습니까? (5 입력 시 종료): ');
          if (stdin.readLineSync()?.trim() == '5') {
            print('이용해 주셔서 감사합니다 ~ 안녕히 가세요 !');
            return;
          }
          print('종료하지 않습니다다.');
          break;
        case '6':
          _clearCart();
          break;
        default:
          print('잘못된 입력입니다. 1, 2, 3, 4, 6 중 하나를 선택해주세요.\n');
      }
    }
  }
}

void main() => ShoppingMall().run();
