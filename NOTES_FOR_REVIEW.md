# Review notes — current state

## Resolved

- ✅ **Repo name:** `vehicle-dynamics-models-matlab-simulink`
- ✅ **MATLAB version:** R2024a (in README + plotting script comments)
- ✅ **Pacejka spelling:** all three `Pacejla` files renamed to `Pacejka` during the copy into the repo. The originals in `portfolio/14dof/` keep the old typo (left untouched as backup).
- ✅ **Duplicate parameter file:** `diff` confirmed `Complete _vehicle_simulation_dof14_model_parameters.m` (with extra space) and `Complete_vehicle_simulation_dof14_model_parameters.m` are byte-identical. Only the no-space version is in the new repo. The space-version still exists in the source folder `portfolio/14dof/` because the file is write-protected — harmless, you can delete it manually if you want.
- ✅ **File organisation:** all `.slx` and `.m` files copied into the subfolder structure shown in the README's File map. Source folder kept intact as backup.
- ✅ **`.slxc` cache files excluded** via `.gitignore` and not copied into the repo.
- ✅ **Plotting scripts written** in `figures/`:
  - `plot_aero_comparison.m` — overlays original vs increased aero
  - `plot_vehicle_comparison.m` — overlays road-car vs formula-car
  - `plot_pacejka_curves.m` — analytical Pacejka curves (no `.mat` needed)
  - `plot_fft_modes.m` — body modes + wheel-hop via `fft_VD.m`
- ✅ **`shared/get_signal.m`** added — robust helper that tries `logsout` → `yout` → direct field access so the same plot script works regardless of how each model logs signals.

## Still on you

1. **Run the four plot scripts in MATLAB** and check the output PNGs. The first run may produce empty plots if your signal names differ from the defaults — the scripts emit a `Could not find signal "X"` warning when this happens. Open the relevant `.mat` file once and inspect `out.logsout` / `fieldnames(out)` to find the actual names, then edit the `SIGNALS` cell array at the top of the affected script. `figures/INSTRUCTIONS.md` walks through this.
2. **Verify the Pacejka-renamed `.slx` files still open cleanly.** I copied them with the corrected name; if any of them used an internal Model Reference or library link to the old `Pacejla` name, the link breaks. Open each one in Simulink and confirm there are no unresolved-reference warnings. If something breaks, copy the original `Pacejla_*.slx` from `portfolio/14dof/` back in under the new name.
3. **Run each model once** to sanity-check that the subfolder reorganisation didn't break parameter-file loading. I kept each model's `*_parameters.m` in the same subfolder as its `.slx`, so this should just work, but verify on at least the 14-DoF and one ride model.
4. **Generate the figures and drop the PNGs into `figures/`.** The plot scripts write their PNGs alongside themselves automatically, so just running them does it.
5. **Delete the (still-existing, write-protected) duplicate** `Complete _vehicle_simulation_dof14_model_parameters.m` in `portfolio/14dof/` if you care about cleaning up the source. It's harmless either way.

## Open items I deferred (lower priority)

- **Per-subfolder mini-READMEs.** Each subfolder could have its own short README explaining that specific model. Skipped for v1 — the master README covers it. Worth adding later if recruiters bookmark a specific model's folder.
- **`LICENSE` file.** README references MIT but no `LICENSE` file is in the repo yet. Add `LICENSE` (MIT template) before pushing public.
- **Course status note inside the README.** The Background section already mentions the course is in progress; if you'd rather frame this differently or remove it, let me know.

## What happens next

When you're ready:
1. You generate the plots in MATLAB (~30-60 min)
2. You initialise git locally and push to GitHub at `github.com/jaykumarpatil9099/vehicle-dynamics-models-matlab-simulink`
3. We update the profile README to swap the placeholder for the real repo link
4. We move on to the Ackermann steering repo (Week 2)

If you want me to write a `HOW_TO_PUBLISH.md` walking through the `git init` / `gh repo create` / `git push` steps, say the word.
