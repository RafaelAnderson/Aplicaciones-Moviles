package com.example.appequipos.controller.fragments

import android.os.Bundle
import android.util.Log
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.example.appequipos.Database.TeamDB
import com.example.appequipos.R
import com.example.appequipos.adapter.TeamAdapter
import com.example.appequipos.models.Team
import kotlinx.android.synthetic.main.fragment_save.view.*

class SaveFragment : Fragment(), TeamAdapter.OnItemClickListener
{
    var team: List<Team> = ArrayList()
    lateinit var recyclerView: RecyclerView

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_save, container, false)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?)
    {
        super.onViewCreated(view, savedInstanceState)

        // Acceso a la base de datos
        team = TeamDB.getInstance(view.context).getTeamDAO().getAllTeams()
        recyclerView = view.rvTeamSave
        recyclerView.layoutManager = LinearLayoutManager(context)
        recyclerView.adapter = TeamAdapter(team, view.context, this)
    }

    override fun onItemClicked(team: Team)
    {
        Log.d("Onclick Favoritos","No hacer nada");
    }
}