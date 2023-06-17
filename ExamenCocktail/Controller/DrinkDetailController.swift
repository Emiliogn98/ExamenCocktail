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
    
    
    
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    
    
    @IBOutlet weak var imageView3: UIImageView!
    
    
    @IBOutlet weak var btnFavoritosOutlet: UIButton!
    
    
    var IdCoctel : Int = 0
    var nombreCoctel : String? = nil
    var categoria : [Drinks] = []
    
    var stCategory : String = "Cocktail"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        updateUI()

    }
    
    
    @IBAction func btnFavoritos(_ sender: UIButton) {
        self.IdCoctel = Int(self.categoria[0].idDrink!)!
        print(self.IdCoctel)
        var drink = Drinks()
        
        drink.strCategory = self.categoria[0].strCategory
        drink.strDrink = self.categoria[0].strDrink
        drink.strAlcoholic = self.categoria[0].strAlcoholic
        drink.strMeasure1 = self.categoria[0].strMeasure1
        drink.strMeasure2 = self.categoria[0].strMeasure2
        drink.strMeasure3 = self.categoria[0].strMeasure3
        drink.strIngredient1 = self.categoria[0].strIngredient1
        drink.strIngredient2 = self.categoria[0].strIngredient2
        drink.strIngredient3 = self.categoria[0].strIngredient3
        drink.strDrinkThumb = self.categoria[0].strDrinkThumb
        print(drink.strDrinkThumb)
        
        let result = DrinkSqliteViewModel.Add(drink: drink)
                    if result.Correct! == true {
                        //Alert
                        let alert = UIAlertController(title: "Mensaje", message: "Se añadio correctamente a Favoritos!", preferredStyle: .alert)
                        let action = UIAlertAction(title: "Aceptar", style: .default)
                        alert.addAction(action)

                            present(alert, animated: true)
                    }else{
                        //Alert
                        //Alert
                        let alert = UIAlertController(title: "Mensaje", message: "Ocurrio un error al agregar a favoritos.", preferredStyle: .alert)
                        let action = UIAlertAction(title: "Aceptar", style: .default)
                        alert.addAction(action)

                            present(alert, animated: true)
                    }
                   // carritoViewModel.GetAll()
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
                        let imageURLString = self.categoria[0].strDrinkThumb
                        UIImage.loadImageFromURL(imageURLString!) { (image) in
                        if let image = image {
                        // La imagen se cargó exitosamente desde la URL
                            self.imageView.image = image
                        } else {
                           // print("error al cargar la imagen")
                            self.imageView.image = UIImage(named: "noImage")
                        }
                            
                        }
                        let imageURLString1 = "https://www.thecocktaildb.com/images/ingredients/\(self.categoria[0].strIngredient1!).png"
                        UIImage.loadImageFromURL(imageURLString1) { (image1) in
                        if let image1 = image1 {
                        // La imagen se cargó exitosamente desde la URL
                            self.imageView1.image = image1
                        } else {
                          //  print("error al cargar la imagen del ingrediente1")
                            self.imageView1.image = UIImage(named: "noImage")
                        }
                            
                        }
                        let imageURLString2 = "https://www.thecocktaildb.com/images/ingredients/\(self.categoria[0].strIngredient2!).png"
                        UIImage.loadImageFromURL(imageURLString2) { (image2) in
                        if let image2 = image2 {
                        // La imagen se cargó exitosamente desde la URL
                            self.imageView2.image = image2
                        } else {
                           // print("error al cargar la imagen del ingrediente2")
                            self.imageView2.image = UIImage(named: "noImage")
                        }
                            
                        }
                        let imageURLString3 = "https://www.thecocktaildb.com/images/ingredients/\(self.categoria[0].strIngredient3).png"
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
               // print(self.categoria)
            }
          
        }
        
    }

}

// MARK: Extension
extension UIImage {
func loadImageFromURL(_ urlString: String, completion: @escaping (UIImage?) -> Void) {
guard let url = URL(string: urlString) else {
completion(nil)
return
}

URLSession.shared.dataTask(with: url) { (data, response, error) in
guard let data = data, let image = UIImage(data: data) else {
completion(nil)
return
}

DispatchQueue.main.async {
completion(image)
}
}.resume()
}
}
