//
//  DrinkDetailController.swift
//  ExamenCocktail
//
//  Created by Emilio García Navarrete on 16/06/23.
//

import UIKit

class DrinkDetailController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var lblNombre: UILabel!
    
    @IBOutlet weak var lblIngrediente1: UILabel!
    
    @IBOutlet weak var lblCantidad1: UILabel!
    
    
    @IBOutlet weak var lblIngrediente2: UILabel!
    
    
    @IBOutlet weak var lblCantidad2: UILabel!
    
    
    @IBOutlet weak var lblIngrediente3: UILabel!
    
    @IBOutlet weak var lblCantidad3: UILabel!
    
    
    var IdCoctel : Int = 0
    var nombreCoctel : String? = nil
    var categoria : [Drinks] = []
    var stCategory : String = "Cocktail"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        updateUI()

    }
    func updateUI(){
        DrinkViewModel.GetById(IdCoctel: self.IdCoctel) { result, error in
            
            DispatchQueue.main.async {
                if result!.drinks != nil{
                    for objDrink in result!.drinks!{
                        self.categoria.append(objDrink)
                        self.lblNombre.text = self.categoria[0].strDrink
                        self.lblIngrediente1.text = self.categoria[0].strIngredient1
                        self.lblIngrediente2.text = self.categoria[0].strIngredient2
                        self.lblIngrediente3.text = self.categoria[0].strIngredient3
                        self.lblCantidad1.text = self.categoria[0].strMeasure1
                        self.lblCantidad2.text = self.categoria[0].strMeasure2
                        self.lblCantidad3.text = self.categoria[0].strMeasure3
                    }
                }
               // print(self.categoria)
            }
          
        }
        
    }

}
