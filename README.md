# 2024-NC2-A50-ScreenTime
## 🎥 Youtube Link
(추후 만들어진 유튜브 링크 추가)

<br>

## 💡 Screen Time
> **What is Screen Time?**<br>
> Screen Time은 기기의 앱 사용 데이터를 공유 및 추적, 관리하는 것과 관련된 기술입니다.

**[기기 사용시간 추적]**<br>
기기 사용 시간, 앱 서비스, 웹 사이트에 머문 시간을 추적하고 기록, 화면깨우기 등

**[스크린타임 제어]**<br>
기기 사용 시간을 추적해서 특정 어플이나 웹사이트에 머무는 시간을 제어 가능(시간제한, 차단)

**[스크린 타임 사용량 공유]**<br>
보호자가 자녀의 스크린타임을 공유받을 수 있고 그것을 보호차원에서 제한 가능

<br>

## 🎯 What we focus on?
**[앱별 사용량 추적 기능를 고른 이유]**
- 스크린타임 기능이 기본적으로 사용량 추적을 제공하는 것을 알게 되었을 때, 매우 다양한 아이디어로 확장 할 수 있겠다고 판단했다.
- 스크린타임이 통제, 제한, 차단하는 기능이 주로 있는데, 듣자마자 강제적이고 부정적인 느낌이 강하게 다가왔다.<br>따라서, 강한 제어가 아닌 스스로 통제할 수 있게 도와주는 기능에 집중하고 싶었다.

**[앱별 사용량 추적 기능을 어떤 식으로 활용했는지]**
- 사용자가 사용을 줄이고 싶은 앱을 설정, 하루동안 사용할 시간을 선택한다.<br>스크린타임을 통해 사용량을 추적하고, 설정한 시간이 다가오면 알림을 보내서 인지를 시켜준다.
- 알림 문구를 사용자가 직접 설정해서 본인과의 대화, 약속을 지키게 도와준다. 

<br>

## 💼 Use Case
<img width="800" alt="usecase" src="https://github.com/DeveloperAcademy-POSTECH/2024-NC2-A50-ScreenTime/assets/68256612/03be900c-3468-4c75-8785-28a4d7e9ec32">




<br>

## 🖼️ Prototype

<img width="300" alt="온보딩2" src="https://github.com/DeveloperAcademy-POSTECH/2024-NC2-A50-ScreenTime/assets/68256612/054e40ec-f06c-4a04-b553-b1b9ae620a50">

<img width="300" alt="알림" src="https://github.com/DeveloperAcademy-POSTECH/2024-NC2-A50-ScreenTime/assets/68256612/2e470b3b-79a9-4d10-bb2a-d379716a56d7">

<br>

## 🛠️ About Code
### class DeviceActivityManager
스크린타임 권한 요청과 앱 모니터링 시작/중단 기능을 관리하는 클래스입니다.

```swift
class DeviceActivityManager {
    
    static let shared = DeviceActivityManager()
    private init() {}
    
    let deviceActivityCenter = DeviceActivityCenter()
    
    // MARK: 스크린타임 권한 요청
    func reqScreenTimePermission() { ... }
   
    // MARK: 모니터링 시작
    func startDeviceActivityMonitoring( ... ) { ... }
      
    // MARK: 모니터링 중단
    func stopDeviceActivityMonitoring() { ... }
}
```


<br>

### func StartActivityMonitoring
사용자가 선택한 앱의 토큰과 제한하고 싶은 시간인 임계값을 인자로 받아 모니터링을 시작하는 함수입니다.
```swift
// MARK: 모니터링 시작
func startDeviceActivityMonitoring(appTokens: FamilyActivitySelection,
                                   hour: Int, minute: Int, 
                                   completion: @escaping (Result<Void, Error>) -> Void) {
    // MARK: 앱 토큰
    let selectedAppTokens = appTokens.applicationTokens
    
    // MARK: 임계값
    let threshold = DateComponents(hour: hour, minute: minute)
    
    // MARK: 모니터링 할 스케줄 설정 - 매일 24시간
    let schedule = DeviceActivitySchedule(
        intervalStart: DateComponents(hour: 0, minute: 0),
        intervalEnd: DateComponents(hour: 23, minute: 59),
        repeats: true
    )
    
    // MARK: 임계값, 앱토큰을 이벤트로 묶음
    let events: [DeviceActivityEvent.Name: DeviceActivityEvent] = [
        .encouraged: DeviceActivityEvent(
            applications: selectedAppTokens,
            threshold: threshold
        )
    ]
    
    // MARK: 앱 모니터링 시작
    do {
        try deviceActivityCenter.startMonitoring(DeviceActivityName.daily, during: schedule, events: events)
    } catch {
        completion(.failure(error))
        return
    }
    
    completion(.success(()))
}
```

<br>

### class DeviceActivityMonitor
앱들을 모니터링하면서 특정 상황(임계값에 도달 등)에 호출되는 함수들을 관리하는 클래스입니다.
```swift
class DeviceActivityMonitorExtension: DeviceActivityMonitor {
    
    let notificationText = UserSettingsManager.shared.loadNotificationText()
    
    // 활동 인터벌이 시작될 때 호출
    override func intervalDidStart(for activity: DeviceActivityName) {
        super.intervalDidStart(for: activity)
        
        // Handle the start of the interval.
    }
    
    // 활동 인터벌이 종료될 때 호출
    override func intervalDidEnd(for activity: DeviceActivityName) {
        super.intervalDidEnd(for: activity)
        
        // Handle the end of the interval.
    }
    
    // 이벤트가 임계값에 도달했을 때 호출
    override func eventDidReachThreshold(_ event: DeviceActivityEvent.Name, activity: DeviceActivityName) {
        super.eventDidReachThreshold(event, activity: activity)
        NotifiactionManager.shared.sendNotification(text: notificationText)
    }
    
    // 인터벌이 시작되기 전에 경고가 발생할 때 호출됩니다.
    override func intervalWillStartWarning(for activity: DeviceActivityName) {
        super.intervalWillStartWarning(for: activity)
        
        // Handle the warning before the interval starts.
    }
    
    // 인터벌이 종료되기 전에 경고가 발생할 때 호출됩니다.
    override func intervalWillEndWarning(for activity: DeviceActivityName) {
        super.intervalWillEndWarning(for: activity)
        
        // Handle the warning before the interval ends.
    }
    
    // 이벤트가 임계값에 도달하기 전에 경고가 발생할 때 호출됩니다.
    override func eventWillReachThresholdWarning(_ event: DeviceActivityEvent.Name, activity: DeviceActivityName) {
        super.eventWillReachThresholdWarning(event, activity: activity)
        
        // Handle the warning before the event reaches its threshold.
    }
}
```
