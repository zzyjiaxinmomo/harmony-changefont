export class GlobalContext {
  // 无参构造函数
  private constructor() { }
  // 全局上下文
  private static instance: GlobalContext;
  // 存储对象变量
  private _objects = new Map<string, Object>();

  /**
   * 单例模式
   * @returns
   */
  public static getContext(): GlobalContext {
    if (!GlobalContext.instance) {
      GlobalContext.instance = new GlobalContext();
    }
    return GlobalContext.instance;
  }

  /**
   * 获取全局对象
   * @param key
   * @returns
   */
  getObject(key: string): Object | undefined {
    return this._objects.get(key);
  }

  /**
   * 存储全局对象
   * @param key
   * @param objectClass
   */
  setObject(key: string, objectClass: Object): void {
    this._objects.set(key, objectClass);
  }
}