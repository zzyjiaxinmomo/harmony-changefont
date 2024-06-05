@Entry
@Component
export default struct ColorPickerView {
  @State barWidth: number = 0
  @State barHeight: number = 0
  @State boardWidth: number = 0
  @State boardHeight: number = 0
  @State barIndicatorSize: number = 0
  @State barIndicatorOffsetY: number = 0
  @State boardIndicatorSize: number = 0
  @State boardIndicatorOffsetX: number = 0
  @State boardIndicatorOffsetY: number = 0
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private crcBar: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)
  private crcBoard: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)
  onColorChange?: (value: string) => void

  /**
   * 颜色条
   */
  @Builder
  ColorBar() {
    Canvas(this.crcBar)
      .onAreaChange((oldValue: Area, newValue: Area) => {
        // 获取组件的宽高
        this.barWidth = parseInt(newValue.width.toString())
        this.barHeight = parseInt(newValue.height.toString())
        this.barIndicatorSize = this.barWidth / 3
        this.barIndicatorOffsetY = -this.barHeight
        // 创建渐变色的范围
        const grad = this.crcBar.createLinearGradient(0, 0, 0, this.barHeight)
        // 设置渐变颜色和比例。
        grad.addColorStop(0, 'rgb(255, 0, 0)')
        grad.addColorStop(1 * 1 / 6, 'rgb(255, 255, 0)')
        grad.addColorStop(2 * 1 / 6, 'rgb(0, 255, 0)')
        grad.addColorStop(3 * 1 / 6, 'rgb(0, 255, 255)')
        grad.addColorStop(4 * 1 / 6, 'rgb(0, 0, 255)')
        grad.addColorStop(5 * 1 / 6, 'rgb(255, 0, 255)')
        grad.addColorStop(1, 'rgb(255, 0, 0)')
        // 设置渐变色
        this.crcBar.fillStyle = grad
        // 绘制矩形
        this.crcBar.fillRect(0, 0, this.barWidth, this.barHeight)
      }).width('20%')
      .borderWidth(0.5)
  }

  @Builder
  ColorBoard() {
    Canvas(this.crcBoard)
      .onAreaChange((oldValue: Area, newValue: Area) => {
        // 获取组件的宽高
        this.boardWidth = parseInt(newValue.width.toString())
        this.boardHeight = parseInt(newValue.height.toString())
        this.boardIndicatorSize = this.boardWidth / 10
        this.boardIndicatorOffsetX = this.boardWidth / 2 + this.boardIndicatorSize / 2
        this.boardIndicatorOffsetY = -this.boardHeight / 2 + this.boardIndicatorSize / 2
        // 清空画布
        this.crcBoard.clearRect(0, 0, this.boardWidth, this.boardHeight)

        // 绘制背景色
        this.crcBoard.fillStyle = 'rgb(255, 0, 0)'
        this.crcBoard.fillRect(0, 0, this.boardWidth, this.boardHeight)

        // 绘制渐变色：白色->透明色
        const gradWhite = this.crcBoard.createLinearGradient(0, 0, this.boardWidth, 0)
        gradWhite.addColorStop(0, 'rgb(255,255,255)')
        gradWhite.addColorStop(1, 'rgba(255,255,255,0)')
        this.crcBoard.fillStyle = gradWhite
        this.crcBoard.fillRect(0, 0, this.boardWidth, this.boardHeight)

        // 绘制渐变色：黑色->透明色
        const gradBlack = this.crcBoard.createLinearGradient(0, this.boardHeight, 0, 0)
        gradBlack.addColorStop(0, 'rgb(0,0,0)')
        gradBlack.addColorStop(1, 'rgba(0,0,0,0)')
        this.crcBoard.fillStyle = gradBlack
        this.crcBoard.fillRect(0, 0, this.boardWidth, this.boardHeight)
      })
      .borderWidth(0.5)
  }

  /**
   * 颜色条指示器
   */
  @Builder
  ColorBarIndicator() {
    Row() {
      if (this.barIndicatorSize != 0) {
        Path()
          .width(this.barIndicatorSize)
          .height(this.barIndicatorSize)
          .commands(`M0 0 L${vp2px(this.barIndicatorSize)} ${vp2px(this.barIndicatorSize /
            2)} L0 ${vp2px(this.barIndicatorSize)} Z`)
          .fill('#00000000')
          .stroke(Color.Black)
          .strokeWidth(0.8)

        Blank()

        Path()
          .width(this.barIndicatorSize)
          .height(this.barIndicatorSize)
          .commands(`M0 ${vp2px(this.barIndicatorSize /
            2)} L${vp2px(this.barIndicatorSize)} 0 L${vp2px(this.barIndicatorSize)} ${vp2px(this.barIndicatorSize)} Z`)
          .fill('#00000000')
          .stroke(Color.Black)
          .strokeWidth(0.8)
      }
    }
    .width('20%')
    .padding(1)
    .offset({ y: this.barIndicatorOffsetY })
    .markAnchor({ y: '50%' })
    .onTouch((event: TouchEvent) => {
      this.onTouchEventBar(event)
    })
  }

  /**
   * 颜色面板指示器
   */
  @Builder
  ColorBoardIndicator() {
    if (this.boardIndicatorSize != 0) {
      Stack() {
        Stack() {
        }
        .width(this.boardIndicatorSize - 1)
        .height(this.boardIndicatorSize - 1)
        .border({ color: Color.White, width: 1, radius: this.boardIndicatorSize / 2 })

        Stack() {
        }
        .width(this.boardIndicatorSize)
        .height(this.boardIndicatorSize)
        .border({ color: Color.Black, width: 1, radius: this.boardIndicatorSize / 2 })
      }
      .offset({ x: this.boardIndicatorOffsetX, y: this.boardIndicatorOffsetY })
      .markAnchor({ x: '50%', y: '50%' })
      .onTouch((event) => {
        this.onTouchEventBoard(event)
      })
    }
  }

  /**
   * 颜色条触摸事件
   */
  onTouchEventBar(event: TouchEvent) {
    // x坐标
    let x = event.touches[0].x
    // y坐标
    let y = event.touches[0].y
    // 触摸区域限制
    if (x < 0) {
      x = 0
    }
    if (x > this.barWidth - 1.2) {
      x = this.barWidth - 1.2
    }
    if (y < 1) {
      y = 1
    }
    if (y > this.barHeight - 1.2) {
      y = this.barHeight - 1.2
    }
    console.log(`颜色条-当前坐标初始：x = ${event.touches[0].x}, y = ${event.touches[0].y}`)
    console.log(`颜色条-当前坐标：x = ${x}, y = ${y}`)
    // 触摸y坐标赋值给指示器偏移量
    this.barIndicatorOffsetY = -this.barHeight + y
    // 获取颜色条坐标点一个像素的颜色值
    let imageData =
      this.crcBar.getImageData(x, y, px2vp(1), px2vp(1))
    console.log(`颜色条-当前颜色：` + JSON.stringify(imageData))
    // 绘制颜色面板
    this.drawColorBoard(`rgb(${imageData.data[0]},${imageData.data[1]},${imageData.data[2]})`)
    // 获取颜色面板选中的颜色
    this.getBoardSelectColor()
  }

  /**
   * 绘制颜色面板
   * @param bgColor 背景颜色 默认颜色：红色
   */
  drawColorBoard(bgColor = 'rgb(255, 0, 0)') {
    console.log(`颜色画板 bgColor 的值是 ${bgColor}`)
    // 清空画布
    this.crcBoard.clearRect(0, 0, this.boardWidth, this.boardHeight)

    // 绘制背景色
    this.crcBoard.fillStyle = bgColor
    this.crcBoard.fillRect(0, 0, this.boardWidth, this.boardHeight)

    // 绘制渐变色：白色->透明色
    const gradWhite = this.crcBoard.createLinearGradient(0, 0, this.boardWidth, 0)
    gradWhite.addColorStop(0, 'rgb(255,255,255)')
    gradWhite.addColorStop(1, 'rgba(255,255,255,0)')
    this.crcBoard.fillStyle = gradWhite
    this.crcBoard.fillRect(0, 0, this.boardWidth, this.boardHeight)

    // 绘制渐变色：黑色->透明色
    const gradBlack = this.crcBoard.createLinearGradient(0, this.boardHeight, 0, 0)
    gradBlack.addColorStop(0, 'rgb(0,0,0)')
    gradBlack.addColorStop(1, 'rgba(0,0,0,0)')
    this.crcBoard.fillStyle = gradBlack
    this.crcBoard.fillRect(0, 0, this.boardWidth, this.boardHeight)
  }

  /**
   * 颜色面板触摸事件
   */
  onTouchEventBoard(event: TouchEvent) {
    // x坐标
    let x = event.touches[0].x
    // y坐标
    let y = event.touches[0].y
    // 触摸区域限制
    if (x < -this.boardWidth / 2) {
      x = -this.boardWidth / 2
    }
    if (x > this.boardWidth / 2 - 1) {
      x = this.boardWidth / 2 - 1
    }
    if (y < -this.boardHeight / 2 + 1) {
      y = -this.boardHeight / 2 + 1
    }
    if (y > this.boardHeight / 2 + 1) {
      y = this.boardHeight / 2 + 1
    }
    console.log('' + this.boardHeight, this.boardWidth)
    console.log(`面板圆圈 touch x=${event.touches[0].x} , y=${event.touches[0].y}`)
    // 触摸xy坐标赋值给指示器偏移量
    this.boardIndicatorOffsetX = x + this.boardIndicatorSize / 2
    this.boardIndicatorOffsetY = y + this.boardIndicatorSize / 2
    // 获取颜色面板选中的颜色
    this.getBoardSelectColor()
  }

  /**
   * 获取颜色面板选中的颜色
   */
  getBoardSelectColor() {
    // 获取坐标点一个像素的颜色值
    let x = this.boardIndicatorOffsetX + this.boardWidth / 2 - this.boardIndicatorSize / 2
    let y = this.boardIndicatorOffsetY + this.boardHeight / 2 - this.boardIndicatorSize / 2
    if (x < 0) {
      x = 0
    }
    if (y < 0) {
      y = 0
    }
    let imageData =
      this.crcBoard.getImageData(x, y, px2vp(1), px2vp(1))
    console.log(`获取颜色时的坐标 x= ${x} y= ${y}`)
    console.log(`颜色面板-当前颜色：` + JSON.stringify(imageData))
    if (this.onColorChange) {
      this.onColorChange(`rgb(${imageData.data[0]},${imageData.data[1]},${imageData.data[2]})`)
    }
  }

  build() {
    Row({ space: 20 }) {
      Column() {
        Stack() {
          this.ColorBoard()
          this.ColorBoardIndicator()
        }
      }

      Column() {
        this.ColorBar()
        this.ColorBarIndicator()
      }
    }
  }
}