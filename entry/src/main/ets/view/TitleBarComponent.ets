import { router } from '@kit.ArkUI';

@Component
export default struct TitleBarComponent {
  isBack: boolean = true
  title: Resource | string = ''

  build() {
    Row() {
      if (this.isBack) {
        Image($r('app.media.ic_public_back'))
          .height(24)
          .width(24)
          .margin({ right: 4 })
          .onClick(() => {
            router.back();
          })
      }

      Text(this.title)
        .fontColor(Color.Black)
        .fontSize($r('sys.float.ohos_id_text_size_headline8'))
        .fontWeight(FontWeight.Medium)
        .margin({ left: 8 })
    }
    .width('100%')
    .height('7%')
    .padding({ left: 16 })
  }
}