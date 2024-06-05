import { preferences } from '@kit.ArkData';
import { GlobalContext } from './GlobalContext';

const PREFERENCES_NAME = 'myPreferences';
const KEY_APP_FONT_SIZE = 'appFontSize';
const KEY_APP_FONT_COLOR = 'appFontColor'
const TAG = '[PreferencesUtil]';

/**
 * 首选项公共类
 */
export class PreferencesUtil {
  /**
   * 创建字体首选项
   * @param context
   */
  createFontPreferences(context: Context) {
    // 获取首选项
    let fontPreferences: Function = (() => {
      let preference: Promise<preferences.Preferences> = preferences.getPreferences(context, PREFERENCES_NAME);
      return preference;
    });
    // 将首选项存储在全局对象里
    GlobalContext.getContext().setObject('getFontPreferences', fontPreferences);
  }

  /**
   * 保存默认字体大小
   * @param fontSize
   */
  saveDefaultFontSize(fontSize: number) {
    // 从全局对象获取首选项函数
    let getFontPreferences: Function = GlobalContext.getContext().getObject('getFontPreferences') as Function;
    getFontPreferences().then((preferences: preferences.Preferences) => {
      // 判断是否存在KEY_APP_FONT_SIZE，如没有，保存并持久性
      preferences.has(KEY_APP_FONT_SIZE).then(async (isExist: boolean) => {
        console.info(TAG, '首选项是否存在appFontSize为 ' + isExist);
        if (!isExist) {
          await preferences.put(KEY_APP_FONT_SIZE, fontSize);
          preferences.flush();
        }
      }).catch((err: Error) => {
        console.error(TAG, '判断主键是否存在，错误: ' + err);
      });
    }).catch((err: Error) => {
      console.error(TAG, '获取首选项失败，错误: ' + err);
    });
  }

  /**
   * 保存修改字体大小
   * @param fontSize
   */
  saveChangeFontSize(fontSize: number) {
    let getFontPreferences: Function = GlobalContext.getContext().getObject('getFontPreferences') as Function;
    getFontPreferences().then(async (preferences: preferences.Preferences) => {
      await preferences.put(KEY_APP_FONT_SIZE, fontSize);
      preferences.flush();
    }).catch((err: Error) => {
      console.error(TAG, '存储首选项失败，错误: ' + err);
    });
  }

  /**
   * 获取修改字体大小
   * @returns
   */
  async getChangeFontSize() {
    let fontSize: number = 0;
    let getFontPreferences: Function = GlobalContext.getContext().getObject('getFontPreferences') as Function;
    fontSize = await (await getFontPreferences()).get(KEY_APP_FONT_SIZE, fontSize);
    return fontSize;
  }

  /**
   * 删除修改字体大小
   */
  async deleteChangeFontSize() {
    let getFontPreferences: Function = GlobalContext.getContext().getObject('getFontPreferences') as Function;
    const preferences: preferences.Preferences = await getFontPreferences();
    let deleteValue = preferences.delete(KEY_APP_FONT_SIZE);
    deleteValue.then(() => {
      console.info(TAG, '已成功删除主键appFontSize。');
    }).catch((err: Error) => {
      console.error(TAG, '未能删除主键appFontSize。原因: ' + err);
    });
  }


  /**
   * 保存默认字体颜色
   * @param color
   */
  saveDefaultFontColor(color: string) {
    // 从全局对象获取首选项函数
    let getFontPreferences: Function = GlobalContext.getContext().getObject('getFontPreferences') as Function;
    getFontPreferences().then((preferences: preferences.Preferences) => {
      // 判断是否存在KEY_APP_FONT_COLOR，如没有，保存并持久性
      preferences.has(KEY_APP_FONT_COLOR).then(async (isExist: boolean) => {
        console.info(TAG, '首选项是否存在KEY_APP_FONT_COLOR为 ' + isExist);
        if (!isExist) {
          await preferences.put(KEY_APP_FONT_COLOR, color);
          preferences.flush();
        }
      }).catch((err: Error) => {
        console.error(TAG, '判断主键是否存在，错误: ' + err);
      });
    }).catch((err: Error) => {
      console.error(TAG, '获取首选项失败，错误: ' + err);
    });
  }

  /**
   * 保存修改字体颜色
   * @param color
   */
  saveChangeFontColor(color: string) {
    let getFontPreferences: Function = GlobalContext.getContext().getObject('getFontPreferences') as Function;
    getFontPreferences().then(async (preferences: preferences.Preferences) => {
      await preferences.put(KEY_APP_FONT_COLOR, color);
      preferences.flush();
    }).catch((err: Error) => {
      console.error(TAG, '存储首选项失败，错误: ' + err);
    });
  }

  /**
   * 获取修改字体颜色
   * @returns
   */
  async getChangeFontColor() {
    let color: string = 'rgb(0,0,0)';
    let getFontPreferences: Function = GlobalContext.getContext().getObject('getFontPreferences') as Function;
    color = await (await getFontPreferences()).get(KEY_APP_FONT_COLOR, color);
    return color;
  }
}

export default new PreferencesUtil()