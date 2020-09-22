package com.example.apprecycler

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import androidx.recyclerview.widget.LinearLayoutManager
import kotlinx.android.synthetic.main.activity_main.*

class MainActivity : AppCompatActivity()
{
    var contacts = ArrayList<Contact>();

    var contactAdapter =  ContactAdapter(contacts)

    override fun onCreate(savedInstanceState: Bundle?)
    {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        loadContacts()
        initView()
    }

    private fun initView()
    {
        rvContact.adapter = contactAdapter
        rvContact.layoutManager = LinearLayoutManager(this)
    }

    fun loadContacts()
    {
        contacts.add(Contact("Rafael Ponte", "964156163"))
        contacts.add(Contact("Anderson Ponte", "964156164"))
        contacts.add(Contact("Rafael Ponte Gaitán", "964156165"))
    }
}