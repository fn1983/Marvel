import Kingfisher
import UIKit

class CharacterCell: UITableViewCell {
    @IBOutlet private weak var thumbnailIcon: UIImageView!
    @IBOutlet private weak var characterName: UILabel!

    func setup(viewModel: CharacterCellViewModel) {
        characterName.text = viewModel.name
        thumbnailIcon.kf.setImage( with: viewModel.thumbnailURL,
            placeholder: UIImage(named: "image_placeholder")
        )
    }
}
