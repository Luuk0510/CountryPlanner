import SwiftUI

enum CountryPlanEditorStrings {
    static let title = "Edit plan"

    static let dates = "Dates"
    static let start = "Start"
    static let end = "End"

    static let details = "Details"
    static let budget = "Budget"
    static let people = "People"

    static let rating = "Rating"
    static let ratingUnavailable = "You can rate after the trip."

    static let notes = "Notes"
    static let notesPlaceholder = "Add notes for your trip..."

    static let done = "Done"

    static let deleteTitle = "Delete this plan?"
    static let deleteButton = "Delete"
    static let cancelButton = "Cancel"
    static let message = "This will remove the trip plan."
}

enum CountryPlanEditorLayout {
    static let pagePadding: CGFloat = 16
    static let gridSpacing: CGFloat = 12
    static let gridMinColumnWidth: CGFloat = 320

    static let notesMinHeight: CGFloat = 160
    static let notesMaxTextWidth: CGFloat = 700

    static let placeholderTopPadding: CGFloat = 8
    static let placeholderLeadingPadding: CGFloat = 5

    static let cardCornerRadius: CGFloat = 20
    static let cardStrokeOpacity: Double = 0.10

    static var gridColumns: [GridItem] {
        [
            GridItem(
                .adaptive(minimum: gridMinColumnWidth),
                spacing: gridSpacing,
                alignment: .top
            )
        ]
    }
}
