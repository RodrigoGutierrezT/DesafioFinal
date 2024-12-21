import SwiftUI

struct CustomButton: View {
    var label: String
    var destination: AnyView
    
    var body: some View {
        NavigationLink(destination: destination) {
            Text(label)
                .frame(width: 200, height: 32)
                .background(.blue)
                .clipShape(.capsule)
                .foregroundStyle(.white)
        }
    }
}


#Preview {
    CustomButton(label: "test", destination: AnyView(Text("test")))
}
