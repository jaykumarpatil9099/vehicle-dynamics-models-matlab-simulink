# How to publish this repo to GitHub

You have two options. The CLI route is faster if you have GitHub CLI (`gh`) installed; the web-UI route works without it.

## Prerequisite: clean up Notes / How-To files

Before publishing, delete the two meta-docs from the repo (they were for our review process, not for recruiters):

```powershell
cd "C:\Users\jayku\Documents\Claude\Projects\Application bot\portfolio\repos\vehicle-dynamics-models-matlab-simulink"
del NOTES_FOR_REVIEW.md
del HOW_TO_PUBLISH.md
del figures\inspect_output.txt
```

(Keep `figures/INSTRUCTIONS.md` — that's useful documentation for anyone running the plot scripts.)

## Option A — GitHub CLI (fastest)

If you have `gh` installed and authenticated:

```powershell
cd "C:\Users\jayku\Documents\Claude\Projects\Application bot\portfolio\repos\vehicle-dynamics-models-matlab-simulink"

git init
git add .
git commit -m "Initial commit: vehicle dynamics modelling toolkit (MATLAB & Simulink)"

gh repo create vehicle-dynamics-models-matlab-simulink --public --source=. --remote=origin --push
```

Done. Visit `https://github.com/jaykumarpatil9099/vehicle-dynamics-models-matlab-simulink` and confirm the README renders with the embedded plots.

## Option B — Web UI

1. Go to https://github.com/new
2. Repository name: `vehicle-dynamics-models-matlab-simulink`
3. Public, no README, no .gitignore (we have our own), no license picker (add later)
4. Create
5. In your shell:

```powershell
cd "C:\Users\jayku\Documents\Claude\Projects\Application bot\portfolio\repos\vehicle-dynamics-models-matlab-simulink"

git init
git add .
git commit -m "Initial commit: vehicle dynamics modelling toolkit (MATLAB & Simulink)"
git branch -M main
git remote add origin https://github.com/jaykumarpatil9099/vehicle-dynamics-models-matlab-simulink.git
git push -u origin main
```

## After publishing

1. **Check the README renders properly on GitHub** — especially the three embedded figures (aero acceleration-vs-speed, vehicle yaw rate, Pacejka front-vs-rear). If any are missing, the file path is wrong or the PNG didn't get committed — check `figures/` on the GitHub web view.
2. **Add a LICENSE file** via the GitHub web UI: Add file → Create new file → name it `LICENSE` → click "Choose a license template" → MIT → commit.
3. **Tell me when it's live.** I'll update your profile README placeholder to point at the real URL, and we can move on to the CV rewrite (which has been waiting on this repo to exist) and then the Ackermann steering repo for next week.
