package com.example.appequipos.controller.activities

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.MenuItem
import androidx.fragment.app.Fragment
import com.example.appequipos.R
import com.example.appequipos.controller.fragments.SaveFragment
import com.example.appequipos.controller.fragments.TeamFragment
import com.google.android.material.bottomnavigation.BottomNavigationView

// Project Structure -> Source y Target Compatibility Version Java 1.8

class MainActivity : AppCompatActivity()
{
    private val onNavigationItemSelectedListener = BottomNavigationView.
    OnNavigationItemSelectedListener { item -> navigateTo(item) }

    private fun navigateTo(item: MenuItem): Boolean
    {
        item.isChecked = true
        return supportFragmentManager
            .beginTransaction()
            .replace(R.id.flFragment, getFragmentFor(item))
            .commit() > 0
    }

    private fun getFragmentFor(item: MenuItem): Fragment
    {
        return when(item.itemId) {
            R.id.menu_home -> TeamFragment()
            R.id.menu_favorite -> SaveFragment()
            else -> TeamFragment()
        }
    }

    override fun onCreate(savedInstanceState: Bundle?)
    {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val navView: BottomNavigationView = findViewById(R.id.bnvMenu)
        navView.setOnNavigationItemSelectedListener(onNavigationItemSelectedListener)
        navigateTo(navView.menu.findItem(R.id.menu_home))
    }
}