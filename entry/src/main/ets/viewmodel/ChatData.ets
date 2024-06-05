import { ItemDirection } from './ItemDirection';

export default class ChatData {
  /**
   * 聊天列表项方向
   */
  itemDirection: ItemDirection = ItemDirection.LEFT;

  /**
   * 聊天列表项内容
   */
  content: Resource | string = '';

  constructor(itemDirection: ItemDirection, content: Resource | string) {
    this.itemDirection = itemDirection
    this.content = content
  }
}
