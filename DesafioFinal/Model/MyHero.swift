//
//  MyHero.swift
//  DesafioFinal
//
//  Created by Rodrigo on 22-12-24.
//

import Foundation
import SwiftData

@Model
final class MyHero {
    var nombre: String
    var descripcion: String
    var habilidadEspecial: String
    
    init(nombre: String, descripcion: String, habilidadEspecial: String) {
        self.nombre = nombre
        self.descripcion = descripcion
        self.habilidadEspecial = habilidadEspecial
    }
}

