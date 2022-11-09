import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:getwidget/components/carousel/gf_carousel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:todolist/src/@shared/bars/buttons_bar.dart';
import 'package:todolist/src/@shared/bars/navbar.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:todolist/src/@shared/cards/cards.dart';
import 'package:todolist/src/@shared/constants/todo_colors.dart';
import 'package:todolist/src/@shared/state/modular_state.dart';
import 'package:todolist/src/@shared/state/state_mixin.dart';
import 'package:todolist/src/presentation/home/stores/home_store.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

final controller = CarouselController();

class _HomePageState extends ModularState<HomePage, HomeStore> {
  int activeIndex = 0;
  @override
  void initState() {
    store.setStateInitial();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;
    final widthIsNotLarge = widthScreen <= 992;

    return SingleChildScrollView(
      child: Flex(
        direction: Axis.vertical,
        children: [
          const Navbar(title: 'To do List'),
          widthIsNotLarge ? _buildBodyMobile(context) : _buildBodyWeb(context),
        ],
      ),
    );
  }

  _buildCenter() {
    return BootstrapCol(
      sizes: 'col-12 .col-sm-6',
      child: Padding(
        padding: const EdgeInsets.only(top: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Olá, Marina.',
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                fontSize: 40,
                fontWeight: FontWeight.w500,
                color: TodoColors.azul,
                decoration: TextDecoration.none,
              ),
            ),
            const SizedBox(height: 55),
            store.obx((tarefas) => _isState(context, tarefas!),
                onEmpty: _isEmpty(),
                onError: (error) => const Center(child: Text('erro')),
                onLoading: const Center(child: Text('load')))
          ],
        ),
      ),
    );
  }

  _isState(BuildContext context, List<Map<String, Object>> listaTarefas) {
    final smallScreen = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        children: [
          BootstrapCol(
            sizes: 'col-12 col-md-10 col-lg-10 col-xl-8',
            child: CarouselSlider.builder(
                carouselController: controller,
                options: CarouselOptions(
                  padEnds: true,
                  disableCenter: false,
                  viewportFraction: smallScreen < 425 ? 1 : 0.7,
                  pageSnapping: false,
                  autoPlayCurve: Curves.easeInBack,
                  height: 250,
                  enlargeCenterPage: false,
                  enableInfiniteScroll: true,
                  autoPlay: false,
                  onPageChanged: (index, reason) {
                    setState(() {
                      activeIndex = index;
                    });
                  },
                ),
                itemCount: listaTarefas.length,
                itemBuilder: (context, index, realIndex) {
                  final title = listaTarefas[index]['titulo'];
                  final subtitle = listaTarefas[index]['itens'] as List;
                  return BootstrapCol(
                    sizes: 'col-12',
                    child: Cards(
                      height: 250,
                      title: title.toString(),
                      subtitle: '${subtitle.length.toString()} tarefas',
                      percentageProgress: '0.3',
                    ),
                  );
                }),
          ),
          const SizedBox(height: 24),
          _buildIndicator(listaTarefas.length),
        ],
      ),
    );
  }

  _buildIndicator(int count) {
    return AnimatedSmoothIndicator(
      activeIndex: activeIndex,
      count: count,
      onDotClicked: animateToSlide,
      effect: const JumpingDotEffect(
        dotWidth: 12,
        dotHeight: 12,
        dotColor: TodoColors.cinza,
        activeDotColor: TodoColors.azul,
      ),
    );
  }

  void animateToSlide(int index) => controller.animateToPage(index);

// --- Desenha a tela quando o estado for vazio (Sem tarefas) ---
  _isEmpty() {
    return Column(
      children: [
        BootstrapCol(
          sizes: 'col-12 col-sm-6',
          child: SvgPicture.asset(
            'assets/images/empty.svg',
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Você não possui tarefas.',
          textAlign: TextAlign.center,
          style: GoogleFonts.roboto(
            fontSize: 32,
            fontWeight: FontWeight.w400,
            color: TodoColors.azul,
            decoration: TextDecoration.none,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }

// -- Desenha as barras de navegação para disposistivos maiores ---
  _buildBodyWeb(BuildContext context) {
    return Row(
      children: [
        const ButtonsBar(),
        Expanded(
          child: Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height - 72,
            child: _buildCenter(),
          ),
        ),
      ],
    );
  }

// -- Desenha as barras de navegação para disposistivos menores ---
  _buildBodyMobile(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _buildCenter(),
        const ButtonsBar(),
      ],
    );
  }
}
