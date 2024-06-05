import SettingData from './SettingData';

export class HomeViewModel {
  settingArr: Array<SettingData> = [];

  initSettingData(): Array<SettingData> {
    if (this.settingArr.length === 0) {
      this.settingArr = new Array();

      this.settingArr.push(new SettingData('应用管理', $r('app.media.ic_app_management')));
      this.settingArr.push(new SettingData('存储空间', $r('app.media.ic_storage')));
      this.settingArr.push(new SettingData('个人隐私', $r('app.media.ic_privacy')));
      this.settingArr.push(new SettingData('字体大小', $r('app.media.ic_setting_the_font_size')));
    }
    return this.settingArr;
  }
}

export default new HomeViewModel();