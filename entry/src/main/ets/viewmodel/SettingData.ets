
export default class SettingData {
  /**
   * 设置列表项名称.
   */
  settingName: Resource | string = ''
  /**
   * 设置列表项图片.
   */
  settingImage: Resource | string = ''


  constructor(settingName: Resource | string, settingImage: Resource | string) {
    this.settingName = settingName
    this.settingImage = settingImage
  }
}
