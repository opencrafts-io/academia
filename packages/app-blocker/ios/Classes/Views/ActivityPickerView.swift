import SwiftUI
import FamilyControls

struct ActivityPickerView: View {
    @State private var selection = FamilyActivitySelection()
    var onDone: (FamilyActivitySelection) -> Void
    var onCancel: () -> Void

    var body: some View {
        NavigationView {
            VStack {
                FamilyActivityPicker(selection: $selection)
                    .edgesIgnoringSafeArea(.all)
            }
            .navigationBarTitle("Select Apps", displayMode: .inline)
            .navigationBarItems(
                leading: Button("Cancel") {
                    onCancel()
                },
                trailing: Button("Done") {
                    onDone(selection)
                }
                .fontWeight(.semibold)
            )
        }
    }
}
