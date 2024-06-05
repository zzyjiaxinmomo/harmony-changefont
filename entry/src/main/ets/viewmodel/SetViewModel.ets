import ChatData from './ChatData'
import { ItemDirection } from './ItemDirection'

export class SetViewModel {
  chatArr: Array<ChatData> = [];

  initChatData(): Array<ChatData> {
    if (this.chatArr.length === 0) {
      this.chatArr = new Array()

      this.chatArr.push(new ChatData(ItemDirection.RIGHT, '你知道现在可以在健康生活添加各种健康目标打卡吗？'))
      this.chatArr.push(new ChatData(ItemDirection.LEFT, '知道，我添加了运动和饮食相关的目标'))
      this.chatArr.push(new ChatData(ItemDirection.RIGHT, '太好了，感觉怎么样？'))
      this.chatArr.push(new ChatData(ItemDirection.LEFT, '生活状态越来越好，你也一起试试吧！'))
    }
    return this.chatArr
  }

  getTextByFontSize(fontSize: number) {
    let fontSizeText: Resource | string = ''
    switch (fontSize) {
      case 14:
        fontSizeText = '小'
        break;
      case 16:
        fontSizeText = '标准'
        break;
      case 18:
        fontSizeText = '大'
        break;
      case 20:
        fontSizeText = '超大'
        break;
      case 24:
        fontSizeText = '特大'
        break;
      default:
        fontSizeText = '标准'
    }
    return fontSizeText
  }
}

export default new SetViewModel();
