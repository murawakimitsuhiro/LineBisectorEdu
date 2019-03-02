//#-hidden-code
//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  The Swift file containing the source code edited by the user of this playground book.
//
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


let red = UIColor(red:0.91, green:0.56, blue:0.56, alpha:1.00)
let blue = UIColor(red:0.58, green:0.74, blue:0.89, alpha:1.00)
let green = UIColor(red:0.53, green:0.74, blue:0.45, alpha:1.00)
//#-end-hidden-code

//: ボタンの色を変える red | green | blue
view.fireButton.backgroundColor = /*#-editable-code placeholder text*/red/*#-end-editable-code*/

view.resetButton.backgroundColor = /*#-editable-code placeholder text*/green/*#-end-editable-code*/


//: 文言を変える
view.descriptionTextLabel.text = /*#-editable-code placeholder text*/"線の真ん中に来たらボタンを押してください"/*#-end-editable-code*/


//: ボタンが押された時のアクションを設定する
view.fireButtonAction = {
    // ボタンが押されるとこの中が実行される
    // movePointStart() | movePointStop()
    // ヒント : 変数を使って、現在丸が「進んでいるのか」「止まっているのか」を記録出来る
    
    //#-editable-code view.movePointStart()
    //#-end-editable-code
}

view.resetButtonAction = {
    //#-editable-code view.pointReset()
    //#-end-editable-code
}
