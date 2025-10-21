import SwiftUI

extension Text {
    func FontRegular(size: CGFloat,
                     color: Color = UserDefaults.standard.bool(forKey: "isOns") ? Color(red: 171/255, green: 181/255, blue: 210/255) : Color(red: 126/255, green: 98/255, blue: 88/255))  -> some View {
        self.font(.custom("Khula-Regular", size: size))
            .foregroundColor(color)
    }
    
    func FontSemiBold(size: CGFloat,
                      color: Color = UserDefaults.standard.bool(forKey: "isOns") ? Color(red: 171/255, green: 181/255, blue: 210/255) : Color(red: 126/255, green: 98/255, blue: 88/255))  -> some View {
        self.font(.custom("Khula-SemiBold", size: size))
            .foregroundColor(color)
    }
    
    func FontBold(size: CGFloat,
                  color: Color = UserDefaults.standard.bool(forKey: "isOns") ? Color(red: 171/255, green: 181/255, blue: 210/255) : Color(red: 126/255, green: 98/255, blue: 88/255))  -> some View {
        self.font(.custom("Khula-Bold", size: size))
            .foregroundColor(color)
    }
    
    func FontLight(size: CGFloat,
                   color: Color = UserDefaults.standard.bool(forKey: "isOns") ? Color(red: 171/255, green: 181/255, blue: 210/255) : Color(red: 126/255, green: 98/255, blue: 88/255))  -> some View {
        self.font(.custom("Khula-Light", size: size))
            .foregroundColor(color)
    }
    func FontExtraBold(size: CGFloat,
                       color: Color = UserDefaults.standard.bool(forKey: "isOns") ? Color(red: 171/255, green: 181/255, blue: 210/255) : Color(red: 126/255, green: 98/255, blue: 88/255))  -> some View {
        self.font(.custom("Khula-ExtraBold", size: size))
            .foregroundColor(color)
    }
}
