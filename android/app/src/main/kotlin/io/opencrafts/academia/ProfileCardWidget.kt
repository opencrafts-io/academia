package io.opencrafts.academia

import android.content.Context
import androidx.compose.runtime.Composable
import androidx.compose.ui.unit.dp
import androidx.glance.GlanceId
import androidx.glance.GlanceModifier
import androidx.glance.GlanceTheme
import androidx.glance.Image
import androidx.glance.ImageProvider
import androidx.glance.appwidget.GlanceAppWidget
import androidx.glance.appwidget.appWidgetBackground
import androidx.glance.appwidget.provideContent
import androidx.glance.layout.Alignment
import androidx.glance.layout.Box
import androidx.glance.layout.Column
import androidx.glance.layout.ContentScale
import androidx.glance.layout.fillMaxSize
import androidx.glance.layout.fillMaxWidth
import androidx.glance.layout.height
import androidx.glance.layout.padding
import androidx.glance.layout.size
import androidx.glance.preview.ExperimentalGlancePreviewApi
import androidx.glance.preview.Preview

class ProfileCardWidget : GlanceAppWidget() {

    override suspend fun provideGlance(
        context: Context,
        id: GlanceId
    ) {
        provideContent {
           ProfileCard()
        }
    }

}

@Composable
@OptIn(ExperimentalGlancePreviewApi::class)
@Preview(widthDp = 300, heightDp = 400)
private fun ProfileCard() {
    GlanceTheme { Box (modifier =
        GlanceModifier
            .fillMaxSize()
            .appWidgetBackground()
    ){
        Column {
            Box(
                modifier = GlanceModifier
                    .fillMaxWidth()
                    .height(300.dp) // Set a fixed height for the image
            ) {
                Image(
                    provider = ImageProvider(R.drawable.college_student), // Placeholder for the main profile picture
                    contentDescription = "Your profile picture",
                    modifier = GlanceModifier.fillMaxSize(),
                    contentScale = ContentScale.Crop
                )

                // Overlay for the BR logo at the top right
                Image(
                    provider = ImageProvider(R.drawable.academia_prod), // Placeholder for the BR logo
                    contentDescription = "Academia Logo",
                    modifier = GlanceModifier
                        .size(48.dp)
                        .padding(8.dp)
//                            .align(Alignment.TopEnd)
                )
            }
        }
    } }
}