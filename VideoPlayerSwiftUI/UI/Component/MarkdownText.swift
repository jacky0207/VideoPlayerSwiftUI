//
//  MarkdownText.swift
//  VideoPlayerSwiftUI
//
//  Created by Jacky Lam on 2024-01-14.
//

import SwiftUI
import MarkdownKit

struct MarkdownText: View {
    var markdown: String
    @State private var height: CGFloat = .zero

    init(_ markdown: String) {
        self.markdown = markdown
    }

    var body: some View {
        InternalMarkdownText(markdown: markdown, height: $height)
            .frame(minHeight: height)
    }

    struct InternalMarkdownText: UIViewRepresentable {
        typealias UIViewType = UILabel
        var markdown: String
        @Binding var height: CGFloat
        private let markdownParser = MarkdownParser()

        func makeUIView(context: Context) -> UILabel {
            let label = UILabel(frame: .zero)
            label.numberOfLines = 0
            label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)  // make its width auto resizing to SwiftUI layout
            return label
        }

        func updateUIView(_ uiView: UILabel, context: Context) {
            uiView.attributedText = markdownParser.parse(markdown)

            DispatchQueue.main.async {
                height = uiView.sizeThatFits(CGSize(width: uiView.bounds.width, height: CGFloat.greatestFiniteMagnitude)).height  // update the height while the width changed due to auto-resizing
            }
        }
    }
}

struct MarkdownText_Preview: PreviewProvider {
    static var previews: some View {
        Group {
            ScrollView {
                MarkdownText("# Famemque horrescere occasus neve\n\n## Ityosque oraque subvolat patetis\n\nLorem markdownum purpura Scyrum, ira aper cruribus purpurea at neve\npraecordiaque illa de erat. Lapithae pollice; nec *aret principiis* sua preces\nregia nam? Templa cruorem sparsos **ardua** protinus *subtraheret fruge*\nexemplum, esse, toros. Ubi quibus sparsaque tutela.\n\n- Suo rogat lumina puto ut frater Lycetum\n- Illos dilecta diva\n- Quoniam Daedalus\n- Vulnere coniuge trisulcis nunc leves\n- Una veluti mea Achivi ferum pectus\n- Pressit tu Iovis mutantur sedere Credulitas ambage\n\n*Vitataque Fame cornibus* volubilitas ad nec insania petito adrectisque ipsa\nanimasque pugnabant ferrum parant. Sensit haec promissaque currus. Tauri levius\ntetigisset dixere est mora ponti, ea posuit pedem circuit: viribus, iterum, e\nseque! Temptare perpetuo ferit non telis Hippotaden milibus valuissent\n[ait](http://incensaquefaveas.com/aera), corpore volenti instruxere Anienis\namor, bis saxum?\n\n## Regemque miscuit capit amanti\n\nTalibus haustus, nec ficti: ille una lacertis praeter dixerat inputet.\n[Instabiles illam](http://cerniset.net/sacraangustis), suique [mentitus manus\nserpente](http://www.opportunacadentem.org/certum): conataque artes latos!\n\n- Alter sua\n- Amentis clamor\n- Suspirat albentibus delusa barbariam Gigantas umbras at\n- Vertit iuventus\n- Ergo conspexi aratri infausto audacia esset\n\n## Rebus in parantem dignum ruptosque collis certamine\n\nNon Creten mirabere concrescere ipse virgineos quos et mensis iunget, nullamque\nLibycas. Uterum monimenta nunc obliquo fiant **illa** ante haeremusque opesque\nOthrys, rursusque indoctum ignibus **comites Iri**. Sermonibus ripa flectant\npudibundaque ardet est medioque nobilis, heres me genetrix videritis illa. Humo\ndum ac accepit mando imagine similis, ingemuit ora omnes offensa omnia causa\nuberibus fertque aequora?\n\nFrustra fecit pan! Unum deosque membra: nova: inter sic genitor terra somni\nAeoliden quam telae. Haec gravis non facies lata mille, procorum possem scopulo,\nsibi sic maius iussa; ante caelestum ungues, opem. Ramis sanguine, si *nec\nmiseris scitatur* pereuntem comites, vult et cani cur ventorum, tuebere\ntenuaverat, multi.\n\nNeque gemitu. Quo moles ex quis certa adhaesit hanc saltu nigrae [adeundi\ncarinae](http://vultus-antiquas.io/) vobis murmure haberet ira factis? Et\n**adiere** inplevere sibi, retia.")
            }

            ScrollView {
                MarkdownText("# Famemque horrescere oc").background(Color.blue)
            }
            .previewDisplayName("Auto-sizing height")
        }
    }
}
