package com.example.appequipos.controller.activities

import android.content.Context
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.ImageView
import android.widget.TextView
import com.example.appequipos.Database.TeamDB
import com.example.appequipos.R
import com.example.appequipos.models.Team
import com.google.android.material.floatingactionbutton.FloatingActionButton
import com.squareup.picasso.OkHttp3Downloader
import com.squareup.picasso.Picasso
import kotlinx.android.synthetic.main.activity_team_details.*

class TeamDetails : AppCompatActivity()
{
    // Iniciar varible del botón flotante
    lateinit var ivLogoDetail: ImageView
    lateinit var tvNameDetail: TextView
    lateinit var tvVenueName: TextView
    lateinit var fabSave: FloatingActionButton

    override fun onCreate(savedInstanceState: Bundle?)
    {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_team_details)

        ivLogoDetail = findViewById(R.id.ivLogoDetail)
        tvNameDetail = findViewById(R.id.tvNameDetail)
        tvVenueName = findViewById(R.id.tvVenueName)
        fabSave = findViewById(R.id.fabSave)

        initFields(this)
    }

    private fun initFields(context: Context)
    {
        val teamObject: Team? = intent.getSerializableExtra("Team") as Team?

        val picBiulder = Picasso.Builder(context)
        picBiulder.downloader(OkHttp3Downloader(context))
        picBiulder.build().load(teamObject?.logo).into(ivLogoDetail)

        tvNameDetail.text = teamObject?.name
        tvVenueName.text = teamObject?.venueName

        fabSave.setOnClickListener()
        {
            saveTeam(teamObject)
            finish()
        }
    }

    private fun saveTeam(teamObject: Team?)
    {
        if (teamObject != null)
        {
            TeamDB.getInstance(this).getTeamDAO().insertTeam(teamObject)
        }
    }
}