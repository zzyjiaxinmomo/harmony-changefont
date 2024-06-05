import ChatData from '../viewmodel/ChatData';
import { ItemDirection } from '../viewmodel/ItemDirection';

@Component
export default struct ChatItemComponent {
  item: ChatData = new ChatData(ItemDirection.LEFT, '');
  @Prop changeFontSize: number = 0;
  @Prop changeFontColor: string = 'rgb(0,0,0)';

  build() {
    Row() {
      Image(this.item.itemDirection === ItemDirection.RIGHT ? $r('app.media.right_head') : $r('app.media.left_head'))
        .width('9%')
        .aspectRatio(1)
        .margin({
          left: this.item.itemDirection === ItemDirection.RIGHT
            ? '2.2%' : '6.7%',
          right: this.item.itemDirection === ItemDirection.RIGHT
            ? '6.7%' : '2.2%'
        })

      ChatContent({ item: this.item, changeFontSize: this.changeFontSize, changeFontColor: this.changeFontColor })
    }
    .alignItems(VerticalAlign.Top)
    .width('100%')
    .direction(this.item.itemDirection === ItemDirection.RIGHT ? Direction.Rtl : Direction.Ltr)
    .margin({ top: '3%' })
  }
}


@Component
struct ChatContent {
  item: ChatData = new ChatData(ItemDirection.LEFT, '');
  @Prop changeFontSize: number = 0;
  @Prop changeFontColor: string = 'rgb(0,0,0)'
  @State isLineFeed: boolean = false;

  build() {
    Row() {
      Text(this.item.content)
        .fontColor('#182341')
        .fontSize(`${this.changeFontSize}fp`)
        .fontColor(`${this.changeFontColor}`)
        .fontWeight(FontWeight.Medium)
        .onAreaChange((oldValue: Area, newValue: Area) => {
          this.isLineFeed = newValue.height > 28;
        })
      if (this.isLineFeed) {
        Blank().layoutWeight(1)
      }
    }
    .constraintSize({ maxWidth: '65%' })
    .direction(Direction.Ltr)
    .padding({
      left: 20,
      right: 20,
      top: 12,
      bottom: 12
    })
    .backgroundColor(this.item.itemDirection === ItemDirection.RIGHT
      ? '#D7E9F3' : '#FFFFFF')
    .borderRadius(24)
  }
}