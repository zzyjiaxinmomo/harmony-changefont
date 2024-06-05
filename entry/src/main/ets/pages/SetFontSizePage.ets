import PreferencesUtil from '../common/PreferencesUtil'
import ChatItemComponent from '../view/ChatItemComponent'
import TitleBarComponent from '../view/TitleBarComponent'
import ChatData from '../viewmodel/ChatData'
import SetViewModel from '../viewmodel/SetViewModel'
import ColorPicker from '../common/ColorPicker'

const TAG = '[SetFontSizePage]';

@Entry
@Component
struct SetFontSizePage {
  @State changeFontSize: number = 0
  @State changeFontColor: string = 'rgb(0,0,0)'
  @State fontSizeText: Resource | string = '标准'
  @State isUpdateFontSize: boolean = false
  private contentArr = SetViewModel.initChatData()

  onPageShow() {
    PreferencesUtil.getChangeFontSize().then((value) => {
      console.log("这里是 onpageshow", value, SetViewModel.getTextByFontSize(value))
      this.changeFontSize = value;
      this.fontSizeText = SetViewModel.getTextByFontSize(value);
      console.info(TAG, 'Get the value of changeFontSize: ' + this.changeFontSize, this.fontSizeText);
      console.log('这是 pageshow 完成设置 fontsizetext 的时间' + new Date().getTime())
      this.isUpdateFontSize = true
    });
    PreferencesUtil.getChangeFontColor().then((value) => {
      this.changeFontColor = value;
    })
  }

  build() {
    Column() {
      // 标题栏组件
      TitleBarComponent({ title: '字体大小设置' })

      if (this.changeFontSize > 0) {
        List() {
          ForEach(this.contentArr, (item: ChatData) => {
            ListItem() {
              ChatItemComponent({
                item: item,
                changeFontSize: this.changeFontSize,
                changeFontColor: this.changeFontColor
              })
            }
          }, (item: ChatData) => JSON.stringify(item))
        }
        .layoutWeight(1)
      }
      if (this.isUpdateFontSize) {
        SliderLayout({
          fontSizeText: $fontSizeText,
          changeFontSize: $changeFontSize,
          changeFontColor: $changeFontColor
        })
      }
    }
    .backgroundColor($r('sys.color.ohos_id_color_sub_background'))
    .height('100%')
    .width('100%')
  }
}


@Component
struct SliderLayout {
  @Link fontSizeText: Resource | string;
  @Link changeFontSize: number;
  @Link changeFontColor: string;

  aboutToAppear() {
    console.log('这是 appear 获取 fontsizetext 的时间' + new Date().getTime())
    console.log(`这是SliderLayout即将 appear 时的 fontsizetext`, this.fontSizeText)
  }

  build() {
    Column() {
      Text('文字大小')
        .fontSize(14)
        .fontColor('#182341')
        .margin({ left: '6.5%', top: '3.2%' })
        .fontWeight(FontWeight.Medium)

      Column() {
        Text(this.fontSizeText)
          .fontSize(14)
          .fontColor('#182341')

        Row() {
          Text('A')
            .fontColor('#182341')
            .fontSize(20)
            .fontWeight(FontWeight.Medium)
            .textAlign(TextAlign.End)
            .width('12.5%')
            .padding({ right: 9 })

          Slider({
            value: this.changeFontSize === 24 ? 22 : this.changeFontSize,
            min: 14,
            max: 22,
            step: 2,
            style: SliderStyle.InSet
          })
            .showSteps(true)
            .width('75%')
            .onChange(async (value: number) => {
              if (this.changeFontSize === 0) {
                this.changeFontSize = await PreferencesUtil.getChangeFontSize();
                this.fontSizeText = SetViewModel.getTextByFontSize(value);
                return;
              }
              this.changeFontSize = (value === 22 ? 24 : value);
              this.fontSizeText = SetViewModel.getTextByFontSize(this.changeFontSize);
              console.log('666666' + value, this.fontSizeText)
              PreferencesUtil.saveChangeFontSize(this.changeFontSize);
            })

          Text('A')
            .fontColor('#182341')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .width('12.5%')
            .padding({ left: 8 })
        }
      }
      .backgroundColor(Color.White)
      .borderRadius(24)
      .width('93.3%')
      .padding({ top: 16, bottom: 21 })
      .margin({
        left: '3.3%',
        right: '3.3%',
        top: '1%',
        bottom: '6.2%',
      })

      Row() {
        ColorPicker({
          onColorChange: (color) => {
            console.log(color)
            this.changeFontColor = color
            PreferencesUtil.saveChangeFontColor(this.changeFontColor)
          }
        })
      }.justifyContent(FlexAlign.Center)
      .height('30%')
      .width('50%')
      .margin({
        bottom: '10%'
      })
    }
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.End)
  }
}