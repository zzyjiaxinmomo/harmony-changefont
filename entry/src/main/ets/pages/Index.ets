import PreferencesUtil from '../common/PreferencesUtil'
import TitleBarComponent from '../view/TitleBarComponent'
import SettingItemComponent from '../view/SettingItemComponent'
import HomeViewModel from '../viewmodel/HomeViewModel';
import SettingData from '../viewmodel/SettingData';
import { router } from '@kit.ArkUI';

const TAG = '[IndexPage]';

@Entry
@Component
struct Index {
  // 字体大小
  @State changeFontSize: number = 16
  @State changeFontColor: string = 'rgb(0,0,0)'
  // 初始化数据
  private settingArr = HomeViewModel.initSettingData();

  // 页面显示时
  onPageShow() {
    PreferencesUtil.getChangeFontSize().then((value) => {
      this.changeFontSize = value;
      console.info(TAG, '获取changeFontSize的值: ' + this.changeFontSize);
    });
    PreferencesUtil.getChangeFontColor().then((value) => {
      this.changeFontColor = value
    })
  }

  @Builder
  SettingItems() {
    List() {
      ForEach(this.settingArr,
        (item: SettingData, index?: number) => {
          ListItem() {
            SettingItemComponent({
              setting: item,
              changeFontSize: this.changeFontSize,
              changeFontColor: this.changeFontColor,
              itemClick: () => {
                // 固定只处理字体大小项跳转
                if (index === 3) {
                  router.pushUrl({
                    url: 'pages/SetFontSizePage'
                  }).catch((error: Error) => {
                    console.info(TAG, '主页跳转错误：' + JSON.stringify(error));
                  });
                }
              }
            })
          }
        }, (item: SettingData) => JSON.stringify(item))
    }
    .divider({
      strokeWidth: 0.5,
      color: '#0d182341',
      startMargin: 44,
      endMargin: '23%'
    })
  }

  build() {
    Column() {
      // 标题栏组件
      TitleBarComponent({ isBack: false, title: '设置' })

      this.SettingItems()
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('sys.color.ohos_id_color_sub_background'))
  }
}