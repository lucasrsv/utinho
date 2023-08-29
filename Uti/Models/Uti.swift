//
//  Uti.swift
//  Uti
//
//  Created by lrsv on 12/06/23.
//

import Foundation
import SwiftUI

struct Uti: Codable {
    var currentCycleDay: Int
    var phase: Phase
    var state: UtiState
    var illness: Illness
    var leisure: Double
    var health: Double
    var nutrition: Double
    var energy: Double
    var blood: Double
    var items: [Item]

    enum CodingKeys: String, CodingKey {
        case currentCycleDay = "current_cycle_day"
        case phase, state, leisure, health, nutrition, blood, items, illness, energy
    }
}

enum UtiState: String, Codable, CaseIterable {
    case pissed
    case pissedHappy
    case homelyHappy
    case homelySad
    case sassyGlass
    case sassyTattoo
    case bodybuilder
    case happy
    case sad
    case sickHpv
    case sickEndometriosis
    case hungry
    case sleepy
}

enum Phase: Codable, CaseIterable {
    case menstrual
    case folicular
    case fertile
    case luteal
    case pms
}

enum Illness: Codable, CaseIterable {
    case no
    case hpv
    case endometrios
}

struct PhaseInfo: Codable {
    var iconPath: String
    var previewDescription: String
    var completeDescription: String
}

extension Uti {
    static func getPhase(phase: Phase) -> PhaseInfo {
        switch phase {
        case .menstrual:
            return(PhaseInfo.init(iconPath: "bloodDrop", previewDescription: "É o primeiro dia da menstruação e também o primeiro dia do ciclo menstrual, nesse momento o Utinho começa a liberar todo o ambiente interno preparado para a fertilização, isso acontece pois o ovulo não foi fecundado. É normal surgirem algumas cólicas então tenha cuidado com ele.", completeDescription: "Durante esse período, o revestimento do útero (endométrio) que se preparou no ciclo anterior é eliminado em forma de sangramento. Isso acontece por que os níveis de estrogênio e progesterona estão baixos, o que desencadeia a descamação do endométrio. Além disso, é nessa fase que os níveis de FSH e LH estão aumentados, estimulando o desenvolvimento dos folículos ovarianos. Nesse momento como o corpo começa a liberar o revestimento uterino, algumas pessoas podem sentir cólicas abdominais, fadiga, dores de cabeça e sensibilidade nos seios."))
        case .folicular:
            return(PhaseInfo.init(iconPath: "follicle", previewDescription: "Momento Body Builder! O Utinho está se preparando para o maior evento de todos (a ovulação). É nesse momento que muitos recursos se reunem para a preparação desse evento.", completeDescription: "Após a menstruação o útero começa a se preparar para a ovulação. É nesse momento em que o estrogênio chega a seu nível máximo. Durante esta fase, um dos folículos ovarianos começa a amadurecer e se preparar para a ovulação. À medida que o folículo cresce os níveis de estrogênio aumentam gradualmente, esse aumento dos níveis de estrogênio faz com que o revestimento uterino comece a se engrossar novamente. Nesse momento os níveis de FSH e LH começam a diminuir após atingirem seu pico."))
        case .fertile:
            return(PhaseInfo.init(iconPath: "ovule", previewDescription: "Alerta! Agora o Utinho está todo saidinho. Após a liberação do óvulo, o corpo está prontíssimo para a fertilização então é normal se ele quiser festejar muito por aí.", completeDescription: "A ovulação é marcada pelo amadurecimento do folículo, esse amadurecimento é o responsável pelo rompimento e liberação de um óvulo maduro, isso acontece pois há um aumento acentuado nos níveis de estrogênio, e ao atingindo seu pico, desencadeia um aumento rápido do LH (pico de LH). Esse pico de LH é o causador da liberação do óvulo maduro do ovário, que agora está pronto para ser fertilizado. Essa fase geralmente ocorre cerca de 14 dias antes do próximo período. Como nessa fase o corpo se prepara para fertilização, é comum sentir um aumento na libido e uma maior sensação de energia. Além de poder haver uma sensação de confiança e maior interesse em interações sociais."))
        case .luteal:
            return(PhaseInfo.init(iconPath: "brick", previewDescription: "Agora, o Utinho está preparando um ambiente aconchegante, caso haja uma visita especial (fertilização). Se isso não acontecer, o Utinho estará pronto para desmontar tudo e jogar fora (menstruação).", completeDescription: "A fase lútea é crucial tanto para a preparação do útero para a gravidez quanto para a regulamentação do início de um novo ciclo caso a fecundação não ocorra, ela ocorre na segunda metade do ciclo menstrual, logo após a ovulação. Durante essa fase, o folículo ovariano que liberou o óvulo na ovulação se transforma em uma estrutura chamada corpo lúteo. O corpo lúteo é responsável por produzir o hormônio progesterona, que desempenha um papel crucial na preparação do útero para uma possível gravidez. Com o aumento dos níveis de progesterona os níveis de LH e FSH diminuírem significativamente devido aos seus efeitos supressores, isso acontece pois nessa fase o cérebro dá um feedback inibidor para que não aja mais ovulação."))
        case .pms:
            return(PhaseInfo.init(iconPath: "storm", previewDescription: "Agora quem tem que tomar cuidado é você! Com a menstruação chegando, se prepare para inchaços, estresses, irritações e alguns foras.", completeDescription: "Após a ovulação, se o óvulo não for fertilizado, o corpo começa a reabsorver o corpo lúteo. Isso faz com que os níveis de progesterona e estrogênio comecem a diminuir rapidamente, o que sinaliza para o revestimento uterino começar a se desprender. Esse é o momento em que o o corpo passa pelo momento pré-menstrual. Essa queda nos níveis hormonais pode levar a uma série de sintomas físicos, emocionais e comportamentais que são característicos da TPM. Algum dos sintomas mais comuns são: inchaço, seios sensíveis e retenção de líquidos. A fadiga, mudança de humor, irritabilidade e ansiedade  também são comuns."))
        }
    }
    
    static func phaseText(phase: Phase) -> String {
        switch (phase) {
        case .menstrual:
            return "FASE MENSTRUAL"
        case .fertile:
            return "FASE FÉRTIL"
        case .folicular:
            return "FASE FOLICULAR"
        case .luteal:
            return "FASE LÚTEA"
        case .pms:
            return "TPM"
        }
    }
}
