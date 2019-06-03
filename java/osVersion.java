public class Foo {
  public static void main(String[] args) {

    System.out.println("운영체제 종류: " + System.getProperty("os.name") );

    System.out.println("자바 가상머신 버전: " + System.getProperty("java.vm.version") );

    System.out.println("클래스 버전: " + System.getProperty("java.class.version") );

    System.out.println("사용자 로그인ID: " + System.getProperty("user.name") );

  }
}
