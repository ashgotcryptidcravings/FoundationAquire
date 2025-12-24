//
//  OrdersView.swift
//  Aquire
//

import SwiftUI

struct OrdersView: View {
    @EnvironmentObject private var store: StoreModel

    var body: some View {
        ScreenScaffold("Orders", subtitle: "Shipments and status updates.") {

            if store.orders.isEmpty {
                AquireSurface {
                    Text("No orders yet.")
                        .font(.system(size: 14, weight: .semibold, design: .rounded))
                        .foregroundStyle(.white.opacity(0.75))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            } else {
                LazyVStack(spacing: 12) {
                    ForEach(store.orders) { order in
                        AquireSurface(cornerRadius: 26, padding: 16) {
                            HStack(alignment: .center, spacing: 12) {
                                Image(systemName: order.product.imageSystemName)
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundStyle(.white.opacity(0.9))

                                VStack(alignment: .leading, spacing: 4) {
                                    Text(order.product.name)
                                        .font(.system(size: 14, weight: .bold, design: .rounded))
                                        .foregroundStyle(.white)

                                    Text(order.date, style: .date)
                                        .font(.system(size: 12, design: .rounded))
                                        .foregroundStyle(.white.opacity(0.65))
                                }

                                Spacer()

                                StatusPill(text: order.status.rawValue, color: Color.white)
                            }
                        }
                    }
                }
            }
        }
    }
}
