//#-hidden-code

import UIKit
import PlaygroundSupport

let page = PlaygroundPage.current
page.needsIndefiniteExecution = true
let proxy = page.liveView as? PlaygroundRemoteLiveViewProxy

func explore() {
    proxy?.send(.string("explore"))
}

// explore()

let view = LiveViewController()
page.liveView = view

var viewWidth: Int {
    return Int(view.view.frame.width/2)
}

var viewHeight: Int {
    return Int(view.view.frame.height)
}

let red = UIColor(red:0.91, green:0.56, blue:0.56, alpha:1.00)
let blue = UIColor(red:0.58, green:0.74, blue:0.89, alpha:1.00)
let green = UIColor(red:0.53, green:0.74, blue:0.45, alpha:1.00)
//#-end-hidden-code



// 変数定義エリア
//#-hidden-code
// 解答例
var isMoving: Bool = false
//#-end-hidden-code



/*:
 ## ボタンの配置
 fireButton(スタート・ストップのボタン)の配置をしています
 x: や、y: の中を変えたらどのような位置に配置されるか試してみましょう。
*/
view.fireButton.center = CGPoint(x: /*#-editable-code placeholder text*/viewWidth/2/*#-end-editable-code*/, y: /*#-editable-code placeholder text*/viewHeight/2/*#-end-editable-code*/)

//: 「リセットボタン」「ステッパー(マイナスとプラスのボタン)」「スピードラベル」も配置してみましょう
view.resetButton.center = CGPoint(x: /*#-editable-code placeholder text*/0/*#-end-editable-code*/, y: /*#-editable-code placeholder text*/0/*#-end-editable-code*/)
view.speedStepper.center = CGPoint(x: /*#-editable-code placeholder text*/0/*#-end-editable-code*/, y: /*#-editable-code placeholder text*/0/*#-end-editable-code*/)
view.speedLabel.center = CGPoint(x: /*#-editable-code placeholder text*/0/*#-end-editable-code*/, y: /*#-editable-code placeholder text*/0/*#-end-editable-code*/)

//#-hidden-code
// 解答例
// view.resetButton.center = CGPoint(x: viewWidth/4*3, y: viewHeight/10*9)
// view.speedStepper.center = CGPoint(x: viewWidth/10*2, y: viewHeight/10*8)
// view.speedLabel.center = CGPoint(x: viewWidth/5*1, y: viewHeight/10*7)
//#-end-hidden-code



/*:
 ## インターフェースパーツの見た目の変更
 */
//: ボタンの色を変えてみましょう red | green | blue
view.fireButton.backgroundColor = /*#-editable-code placeholder text*/red/*#-end-editable-code*/
view.resetButton.backgroundColor = /*#-editable-code placeholder text*/green/*#-end-editable-code*/

//: 文言を変えてみましょう
view.descriptionTextLabel.text = /*#-editable-code placeholder text*/"線の真ん中に来たらボタンを押してください"/*#-end-editable-code*/



/*:
 ## アクションのプログラム
 ボタンが押された時のアクションを設定してみましょう
*/
view.fireButtonAction = {
    // ボタンが押されるとこの中が実行されます
    // view.movePointStart() | view.movePointStop()
    // ヒント : 変数を使って、現在丸が「進んでいるのか」「止まっているのか」を記録出来ます
    //#-editable-code view.movePointStart()
    //#-end-editable-code
    //#-hidden-code
    // 解答例
    // (変数定義エリアに変数定義済み)
    if isMoving {
        view.movePointStop()
        isMoving = false
    } else {
        view.movePointStart()
        isMoving = true
    }
    //#-end-hidden-code
}

view.resetButtonAction = {
    //#-editable-code view.pointReset()
    //#-end-editable-code
    
    //#-hidden-code
    // 解答例
//    view.pointReset()
    //#-end-hidden-code
}



/*:
 ## ステッパーの挙動の変更
 丸が動く速度を調整してみましょう。
 */
/*:
 マイナス、プラスを押した時に丸の速さがどれくらい変わるか
 値を変更してみましょう
 */
view.speedStepper.stepValue = /*#-editable-code placeholder text*/2/*#-end-editable-code*/

