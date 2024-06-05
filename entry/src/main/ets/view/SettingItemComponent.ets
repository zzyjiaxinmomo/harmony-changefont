import SettingData from '../viewmodel/SettingData';

@Component
export default struct SettingItemComponent {
  private setting: SettingData = new SettingData('', '');
  @Prop changeFontSize: number = 0;
  @Prop changeFontColor: string = 'rgb(0,0,0)'
  itemClick: Function = () => {
  };

  build() {
    Row() {
      Image(this.setting.settingImage)
        .height(24)
        .width(24)
        .margin({ left: 12, right: 8 })

      Text(this.setting.settingName)
        .fontSize(`${this.changeFontSize}fp`)
        .fontColor(`${this.changeFontColor}`)
        .fontWeight(FontWeight.Medium)
    }
    .width('100%')
    .height(48)
    .onClick(() => {
      this.itemClick();
    })
  }
}