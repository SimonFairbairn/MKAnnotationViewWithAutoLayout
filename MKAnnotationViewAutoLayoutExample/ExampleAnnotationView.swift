//
//  ExampleAnnotationView.swift
//  MKAnnotationViewAutoLayoutExample
//
//  Created by Simon Fairbairn on 07/05/2017.
//  Copyright © 2017 Voyage Travel Apps. All rights reserved.
//

import MapKit

class ExampleAnnotationView: MKAnnotationView {

	@IBOutlet weak var titleLabel : UILabel?
	@IBOutlet weak var containerView : UIView?
	@IBOutlet weak var contentView : UIView?
	
	override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
		super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
		self.setup()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		self.setup()
	}

	
	func setup() {
		
		guard let nibView = loadViewFromNib() else {
			return
		}
		
		self.contentView = nibView
		backgroundColor = UIColor.clear
		contentView?.backgroundColor = UIColor.clear
		
		containerView?.layer.cornerRadius = 10
		containerView?.layer.shadowColor = UIColor.black.withAlphaComponent(0.4).cgColor
		containerView?.layer.shadowOpacity = 1
		containerView?.layer.shadowOffset = CGSize.zero
		containerView?.layer.shadowRadius = 4
		
		bounds = nibView.frame
		addSubview(nibView)
		
		contentView?.translatesAutoresizingMaskIntoConstraints = false
		containerView?.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
		containerView?.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
		
	}
	
	func loadViewFromNib() -> UIView! {
		let bundle = Bundle(for: type(of: self))
		let name =  "ExampleAnnotationView"
		let nib = UINib(nibName: name, bundle: bundle)
		let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
		return view
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		bounds = containerView!.bounds
	}
	override func prepareForReuse() {
		super.layoutSubviews()
		bounds = containerView!.bounds
		
	}

}
