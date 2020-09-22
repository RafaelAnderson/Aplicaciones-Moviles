package com.example.apprecycler

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import kotlinx.android.synthetic.main.prototype_contact.view.*

// ContactPrototype -> Cambiar a constructor de invocación y ContactAdpter - Añadir miembros

class ContactAdapter(var contacts: ArrayList<Contact>): RecyclerView.Adapter<ContactPrototype>()
{
    // Crear el prototipo (ViewHolder) para cada elemento/fila
    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ContactPrototype {
        val view = LayoutInflater.from(parent.context)
            .inflate(R.layout.prototype_contact, parent, false)

        return ContactPrototype(view)
    }

    // Conecta la información con la vista
    override fun getItemCount(): Int {
        return contacts.size
    }

    // Tamaño
    // Holder cambio por contactPrototype
    override fun onBindViewHolder(contactPrototype: ContactPrototype, position: Int) {
        contactPrototype.bind(contacts.get(position))
    }
}

// Alt + enter en Contact Prototype (Linea 8), Create Class y Contact Adapter.kt
// ALt + enter RecyclerView.ViewHolder - Add Constructor Parameters

class ContactPrototype(itemView: View) : RecyclerView.ViewHolder(itemView)
{
    val tvName = itemView.tvName
    val tvTelephone = itemView.tvTelephone

    fun bind(contact: Contact)
    {
        tvName.text = contact.name
        tvTelephone.text = contact.telephone
    }
}
