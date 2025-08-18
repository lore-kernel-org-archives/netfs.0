Received: from thor.imp.ch (thor.imp.ch [157.161.4.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDBD258EEE;
	Mon, 18 Aug 2025 13:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.161.4.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755523469; cv=none; b=SQz96sRut+4wxQhHRd8+nZK79Pj2tPvWP+eIpWtk76UxD/5EPSrGH0zGZAyHwL6Ejb/ny/nWH4R4lP6pxCx5P/Lp7aZAPDuUXMSP4L1QY+7YzAWBCzymcueAqPLHOn5TEcTdqnW3jK6i5IJWG4jZQcpdYw/QZKE183NTpVl4Eao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755523469; c=relaxed/simple;
	bh=rP2pkqvZ6KHnHrp908Xbh2yw37TmKp9f7Ka2g3NLh+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B7Kt+Zwg+fxaN0kuaN/xtuu8CtbYAInXOsMzdgkb6nisLPzwRsYgLK7cMe8fktXxZzj1Eq1rpf3ihmwRhXSRHTjz1lkD2b8nK3NUNzd3GHBPaxt2uYSBvcJk+XDha1kxDEZQhL6WWmH68vWOvgJjeDEoXOlq7eKA0i7dUC5eKvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imp.ch; spf=pass smtp.mailfrom=imp.ch; dkim=pass (1024-bit key) header.d=imp.ch header.i=@imp.ch header.b=omqiKmHL; arc=none smtp.client-ip=157.161.4.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imp.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imp.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=imp.ch header.i=@imp.ch header.b="omqiKmHL"
Received: from go.imp.ch (go.imp.ch [IPv6:2001:4060:1:4133:f8d3:e3ff:fee7:5808])
	by thor.imp.ch (8.18.1/8.13.3) with ESMTPS id 57IDO9pb067779
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Mon, 18 Aug 2025 15:24:10 +0200 (CEST)
	(envelope-from benoit.panizzon@imp.ch)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=imp.ch; s=mail;
	t=1755523450; bh=rP2pkqvZ6KHnHrp908Xbh2yw37TmKp9f7Ka2g3NLh+Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=omqiKmHLOC7jaQ+WgdTVhIKVC6hlPSPLEl50u0OVRmPn2U9kdUYfji61AwsVStsuX
	 +k8b7cqtvg/Gonatw5+mDIlajGnW3811w9p5xPkeyD0lkXdpVarcRRpUj54e57KcJu
	 wnwxcKwc03VgLei/iKf7/ibE2bub0k/AMNSx3tE0=
Date: Mon, 18 Aug 2025 15:24:09 +0200
From: Benoit Panizzon <benoit.panizzon@imp.ch>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: Max Kellermann <max.kellermann@ionos.com>,
        David Howells
 <dhowells@redhat.com>,
        Paulo Alcantara <pc@manguebit.org>, netfs@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benoit Panizzon <bp@imp.ch>, 1111455@bugs.debian.org,
        stable@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [bp@imp.ch: Bug#1111455: linux-image-6.12.41+deb13-amd64:
 kernel BUG at fs/netfs/read_collect.c:316 netfs: Can't donate prior to
 front]
Message-ID: <20250818152409.2d2db023@go.imp.ch>
In-Reply-To: <20250818151814.18d5dcd4@go.imp.ch>
References: <aKMdIgkSWw9koCPC@eldamar.lan>
	<20250818151814.18d5dcd4@go.imp.ch>
Organization: ImproWare AG
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi

May be related:
https://security-tracker.debian.org/tracker/CVE-2025-21988

Mit freundlichen Gr=C3=BCssen

-Beno=C3=AEt Panizzon-
--=20
I m p r o W a r e   A G    -    Leiter Commerce Kunden
______________________________________________________

Zurlindenstrasse 29             Tel  +41 61 826 93 00
CH-4133 Pratteln                Fax  +41 61 826 93 01
Schweiz                         Web  http://www.imp.ch
______________________________________________________
