//
//  FavoritosDetailController.swift
//  ExamenCocktail
//
//  Created by MacBookMBA4 on 16/06/23.
//

import UIKit

class FavoritosDetailController: UIViewController {

    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var lblNombre: UILabel!
    
    @IBOutlet weak var lblIngrediente1: UILabel!
    
    @IBOutlet weak var lblCantidad1: UILabel!
    
    @IBOutlet weak var lblIngrediente2: UILabel!
    
    @IBOutlet weak var lblCantidad2: UILabel!
    
    
    @IBOutlet weak var lblIngrediente3: UILabel!
    
    @IBOutlet weak var lblCantidad3: UILabel!
    
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    
    @IBOutlet weak var btnFavoritosOutlet: UIButton!
    
    
    var IdCoctel : Int = 0
    var nombreCoctel : String? = nil
    var categoria : [Drinks] = []
    var result = Result()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()

    }
    
    
    @IBAction func btnFavoritos(_ sender: UIButton) {
        
        var result = DrinkSqliteViewModel.Delete(idCoctel: self.IdCoctel)
        if result.Correct! == true {
            //Alert
            
            let alert = UIAlertController(title: "Mensaje", message: "Se quito de Favoritos!", preferredStyle: .alert)
            let action = UIAlertAction(title: "Aceptar", style: .default)
            alert.addAction(action)

                present(alert, animated: true)
        }
        
    }
    
    func updateUI(){
      
        var result = DrinkSqliteViewModel.GetbyId(idCoctel: self.IdCoctel)
        if result.Correct! == true{
            var drink = result.Object as! Drinks
            self.lblNombre.text = drink.strDrink
            self.lblIngrediente1.text = drink.strIngredient1
            self.lblIngrediente2.text = drink.strIngredient2
            self.lblIngrediente3.text = drink.strIngredient3
            self.lblCantidad1.text = drink.strMeasure1
            self.lblCantidad2.text = drink.strMeasure2
            self.lblCantidad3.text = drink.strMeasure3
            let imageURLString = drink.strDrinkThumb
            UIImage.loadImageFromURL(imageURLString!) { (image) in
            if let image = image {
            // La imagen se cargó exitosamente desde la URL
                self.imageView.image = image
            } else {
               // print("error al cargar la imagen")
                self.imageView.image = UIImage(named: "noImage")
            }
                
            }
            let imageURLString1 = "https://www.thecocktaildb.com/images/ingredients/\(drink.strIngredient1!).png"
            UIImage.loadImageFromURL(imageURLString1) { (image1) in
            if let image1 = image1 {
            // La imagen se cargó exitosamente desde la URL
                self.imageView1.image = image1
            } else {
              //  print("error al cargar la imagen del ingrediente1")
                self.imageView1.image = UIImage(named: "noImage")
            }
                
            }
            let imageURLString2 = "https://www.thecocktaildb.com/images/ingredients/\(drink.strIngredient2!).png"
            UIImage.loadImageFromURL(imageURLString2) { (image2) in
            if let image2 = image2 {
            // La imagen se cargó exitosamente desde la URL
                self.imageView2.image = image2
            } else {
               // print("error al cargar la imagen del ingrediente2")
                self.imageView2.image = UIImage(named: "noImage")
            }
                
            }
            let imageURLString3 = "https://www.thecocktaildb.com/images/ingredients/\(drink.strIngredient3).png"
            UIImage.loadImageFromURL(imageURLString3) { (image3) in
            if let image3 = image3 {
            // La imagen se cargó exitosamente desde la URL
                self.imageView3.image = image3
            } else {
               // print("error al cargar la imagen del ingrediente3")
                self.imageView3.image = UIImage(named: "noImage")
            }
                
            }
            
        }
    }
}//class
