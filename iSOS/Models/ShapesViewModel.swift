import SwiftUI

struct QuestionBlobShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = 260.0
        let height = 86.0
        path.move(to: CGPoint(x: 0.0251*width, y: 0.23256*height))
        path.addCurve(to: CGPoint(x: 0.10232*width, y: 0), control1: CGPoint(x: 0.0251*width, y: 0.10412*height), control2: CGPoint(x: 0.05967*width, y: 0))
        path.addLine(to: CGPoint(x: 0.92278*width, y: 0))
        path.addCurve(to: CGPoint(x: width, y: 0.23256*height), control1: CGPoint(x: 0.96543*width, y: 0), control2: CGPoint(x: width, y: 0.10412*height))
        path.addLine(to: CGPoint(x: width, y: 0.76744*height))
        path.addCurve(to: CGPoint(x: 0.92278*width, y: height), control1: CGPoint(x: width, y: 0.89588*height), control2: CGPoint(x: 0.96543*width, y: height))
        path.addLine(to: CGPoint(x: 0.0251*width, y: height))
        path.addLine(to: CGPoint(x: 0.00672*width, y: height))
        path.addCurve(to: CGPoint(x: 0.00338*width, y: 0.97674*height), control1: CGPoint(x: 0.00271*width, y: height), control2: CGPoint(x: 0.00063*width, y: 0.98556*height))
        path.addCurve(to: CGPoint(x: 0.0251*width, y: 0.83603*height), control1: CGPoint(x: 0.01715*width, y: 0.94177*height), control2: CGPoint(x: 0.0251*width, y: 0.89028*height))
        path.addLine(to: CGPoint(x: 0.0251*width, y: 0.23256*height))
        path.closeSubpath()
        return path
    }
}

struct ReplyBlobShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.9749*width, y: 0.23256*height))
        path.addCurve(to: CGPoint(x: 0.89768*width, y: 0), control1: CGPoint(x: 0.9749*width, y: 0.10412*height), control2: CGPoint(x: 0.94033*width, y: 0))
        path.addLine(to: CGPoint(x: 0.07722*width, y: 0))
        path.addCurve(to: CGPoint(x: 0, y: 0.23256*height), control1: CGPoint(x: 0.03457*width, y: 0), control2: CGPoint(x: 0, y: 0.10412*height))
        path.addLine(to: CGPoint(x: 0, y: 0.76744*height))
        path.addCurve(to: CGPoint(x: 0.07722*width, y: height), control1: CGPoint(x: 0, y: 0.89588*height), control2: CGPoint(x: 0.03457*width, y: height))
        path.addLine(to: CGPoint(x: 0.9749*width, y: height))
        path.addLine(to: CGPoint(x: 0.99328*width, y: height))
        path.addCurve(to: CGPoint(x: 0.99662*width, y: 0.97674*height), control1: CGPoint(x: 0.99729*width, y: height), control2: CGPoint(x: 0.99937*width, y: 0.98556*height))
        path.addCurve(to: CGPoint(x: 0.9749*width, y: 0.83603*height), control1: CGPoint(x: 0.98285*width, y: 0.94177*height), control2: CGPoint(x: 0.9749*width, y: 0.89028*height))
        path.addLine(to: CGPoint(x: 0.9749*width, y: 0.23256*height))
        path.closeSubpath()
        return path
    }
}
