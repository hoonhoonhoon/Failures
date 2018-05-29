## SwiftOptimization
**컴파일 옵티마이제이션 관련 장애 추적 프로젝트**
*장애 내용
앱스토어 배포 버전에서 크래시 발생
RxSwift, RxCocoa를 사용한 코드가 관련됨
### Environment
- Libraries
1. cocoapods 1.3.1
2. Swift 4.1
3. RxSwift 4.1.2
4. RxCocoa 4.1.2

- Application
1. xcode 9.3.1
2. app target version 11.3
3. Build Settings -> Swift Compiler - Code Generation -> Optimization Level -> Optimization for Speed
